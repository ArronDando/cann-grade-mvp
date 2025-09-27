-- 001_init_schema.sql
create extension if not exists "pgcrypto";
create extension if not exists "uuid-ossp";

do $$ begin create type product_form as enum ('flower','oil','vape','other'); exception when duplicate_object then null; end $$;
do $$ begin create type batch_status as enum ('in_stock','out_of_stock','backorder','discontinued'); exception when duplicate_object then null; end $$;
do $$ begin create type moderation_state as enum ('pending','approved','rejected'); exception when duplicate_object then null; end $$;
do $$ begin create type user_role as enum ('patient','clinic','producer','admin'); exception when duplicate_object then null; end $$;

create or replace function set_updated_at() returns trigger language plpgsql as $$
begin new.updated_at = now(); return new; end $$;

create table if not exists products (
  id uuid primary key default gen_random_uuid(),
  sku text not null unique,
  brand text,
  product_name text not null,
  form product_form not null default 'flower',
  thc_pct numeric(4,1),
  cbd_pct numeric(4,1),
  pack_size text,
  active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create trigger trg_products_updated before update on products for each row execute function set_updated_at();

create table if not exists batches (
  id uuid primary key default gen_random_uuid(),
  product_id uuid not null references products(id) on delete cascade,
  batch_no text not null,
  expiry_date date,
  coa_url text,
  status batch_status not null default 'in_stock',
  received_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (product_id, batch_no)
);
create index if not exists idx_batches_product on batches(product_id);
create trigger trg_batches_updated before update on batches for each row execute function set_updated_at();

create table if not exists pharmacies (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  gln text,
  city text,
  contact_email text,
  created_at timestamptz not null default now()
);

create table if not exists inventory (
  id uuid primary key default gen_random_uuid(),
  pharmacy_id uuid not null references pharmacies(id) on delete cascade,
  batch_id uuid not null references batches(id) on delete cascade,
  stock_status batch_status not null default 'in_stock',
  updated_at timestamptz not null default now(),
  unique (pharmacy_id, batch_id)
);
create index if not exists idx_inventory_pharmacy on inventory(pharmacy_id);
create index if not exists idx_inventory_batch on inventory(batch_id);

create table if not exists profiles (
  id uuid primary key,
  display_name text,
  role user_role not null default 'patient',
  clinic_id uuid,
  pharmacy_id uuid,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create trigger trg_profiles_updated before update on profiles for each row execute function set_updated_at();

create table if not exists consent_logs (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references profiles(id) on delete cascade,
  consent_version text not null,
  consent_text text not null,
  created_at timestamptz not null default now()
);
create index if not exists idx_consent_user on consent_logs(user_id);

create table if not exists reviews (
  id uuid primary key default gen_random_uuid(),
  product_id uuid not null references products(id) on delete cascade,
  batch_id uuid references batches(id) on delete set null,
  author_id uuid not null references profiles(id) on delete cascade,
  stars smallint not null check (stars between 1 and 5),
  title text,
  body text,
  photo_url text,
  consent_version text not null,
  is_flagged boolean not null default false,
  mod_state moderation_state not null default 'approved',
  submitted_at timestamptz not null default now()
);
create index if not exists idx_reviews_product on reviews(product_id);
create index if not exists idx_reviews_batch on reviews(batch_id);
create index if not exists idx_reviews_author on reviews(author_id);
create index if not exists idx_reviews_modstate on reviews(mod_state);
create index if not exists idx_reviews_submitted_at on reviews(submitted_at);

create or replace view product_rating_stats as
select
  p.id as product_id,
  p.sku,
  p.brand,
  p.product_name,
  count(*) filter (where r.mod_state='approved')::int as review_count,
  round(avg(r.stars) filter (where r.mod_state='approved')::numeric, 2) as avg_stars,
  count(*) filter (where r.mod_state='approved' and r.submitted_at >= now() - interval '90 days')::int as review_count_90d,
  round(avg(r.stars) filter (where r.mod_state='approved' and r.submitted_at >= now() - interval '90 days')::numeric, 2) as avg_stars_90d
from products p
left join reviews r on r.product_id = p.id
group by p.id, p.sku, p.brand, p.product_name;

create or replace view product_badges as
select
  product_id,
  sku,
  product_name,
  review_count,
  avg_stars,
  case when review_count >= 10 and avg_stars >= 4.5 then true else false end as qualifies_for_badge,
  case when review_count >= 10 and avg_stars >= 4.5
       then 'Rated ' || avg_stars || '/5 by ' || review_count || ' patients'
       else null end as badge_text
from product_rating_stats;

alter table products enable row level security;
alter table batches enable row level security;
alter table pharmacies enable row level security;
alter table inventory enable row level security;
alter table profiles enable row level security;
alter table consent_logs enable row level security;
alter table reviews enable row level security;

create policy "public read products" on products for select using (true);
create policy "public read batches" on batches for select using (true);

create policy "read own profile" on profiles for select using (auth.uid() = id);
create policy "update own profile" on profiles for update using (auth.uid() = id);
create policy "admin read all profiles" on profiles for select using ((auth.jwt()->>'role') = 'admin');

create policy "read own consent" on consent_logs for select using (auth.uid() = user_id);
create policy "insert own consent" on consent_logs for insert with check (auth.uid() = user_id);
create policy "admin read all consent" on consent_logs for select using ((auth.jwt()->>'role') = 'admin');

create policy "public read approved reviews" on reviews for select using (mod_state = 'approved');
create policy "patients insert reviews" on reviews
  for insert with check (auth.uid() = author_id and coalesce((auth.jwt()->>'role'),'patient') in ('patient','admin'));
create policy "author edit brief window" on reviews for update using (auth.uid() = author_id and submitted_at > now() - interval '15 minutes');
create policy "author delete brief window" on reviews for delete using (auth.uid() = author_id and submitted_at > now() - interval '15 minutes');
create policy "admin manage reviews" on reviews for all using ((auth.jwt()->>'role') = 'admin') with check ((auth.jwt()->>'role') = 'admin');

create policy "b2b read pharmacies" on pharmacies for select using (coalesce((auth.jwt()->>'role'),'patient') in ('clinic','producer','admin'));
create policy "b2b read inventory" on inventory for select using (coalesce((auth.jwt()->>'role'),'patient') in ('clinic','producer','admin'));

create policy "admin manage products" on products for all using ((auth.jwt()->>'role') = 'admin') with check ((auth.jwt()->>'role') = 'admin');
create policy "admin manage batches" on batches for all using ((auth.jwt()->>'role') = 'admin') with check ((auth.jwt()->>'role') = 'admin');
create policy "admin manage inventory" on inventory for all using ((auth.jwt()->>'role') = 'admin') with check ((auth.jwt()->>'role') = 'admin');
