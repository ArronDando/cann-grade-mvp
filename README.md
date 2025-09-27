# Cann-Grade MVP (Patient Feedback Transparency)

Weekend PoC: patient review capture + clinic dashboard with Supabase (Postgres + RLS), Bubble/FlutterFlow, and Retool.

## Quick start
1. Run migrations in **Supabase SQL Editor** in order:
   - `db/migrations/001_init_schema.sql`
   - `db/migrations/002_seed_sentinel.sql`
   - `db/migrations/003_add_review_audit.sql` (optional, adds audit trail)
2. Import `db/seeds/uk_cannabis_skus.csv` into the `products` table.
3. Create Storage bucket `review-photos` (public for MVP).
4. Set JWT custom claim `role=admin` on your admin user for RLS admin policies.
5. Wire front-ends:
   - Patient app → sign-up → consent → review → feed.
   - Retool dashboard → connect to `product_rating_stats` & `product_badges` views.

## Stack
- **DB**: Supabase (EU), Postgres, RLS
- **Patient App**: Bubble or FlutterFlow
- **Dashboard**: Retool

## Security & Compliance
- Public reads: `products`, `batches`, and `reviews` (approved only).
- RLS: users write their own reviews; admins manage catalog/reviews via JWT role.
- GDPR: explicit consent stored in `consent_logs`; UGC policy avoids medical claims.

---