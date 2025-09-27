-- 003_add_review_audit.sql
create table if not exists review_audit (
  id uuid primary key default gen_random_uuid(),
  review_id uuid not null,
  actor_id uuid,
  old_mod_state moderation_state,
  new_mod_state moderation_state,
  changed_at timestamptz not null default now(),
  reason text
);

create or replace function log_review_mod_changes()
returns trigger language plpgsql as $$
begin
  if (old.mod_state is distinct from new.mod_state) then
    insert into review_audit (review_id, actor_id, old_mod_state, new_mod_state, reason)
    values (old.id, auth.uid(), old.mod_state, new.mod_state, 'state change');
  end if;
  return new;
end $$;

drop trigger if exists trg_reviews_audit on reviews;
create trigger trg_reviews_audit
after update on reviews
for each row execute function log_review_mod_changes();
