# Database Reference

## Enums
- `product_form`: `flower | oil | vape | other` (lowercase only)
- `batch_status`: `in_stock | out_of_stock | backorder | discontinued`
- `moderation_state`: `pending | approved | rejected`
- `user_role`: `patient | clinic | producer | admin`

## Tables
- `products` (catalog)
- `batches` (product_id, batch_no unique)
- `pharmacies`, `inventory`
- `profiles` (maps to `auth.users`.id)
- `consent_logs` (Article 9 explicit consent)
- `reviews` (UGC, stars 1–5, moderation state)

## Views (treat as dashboard API)
- `product_rating_stats`
- `product_badges`

## RLS Summary
- Public `SELECT` on `products`, `batches`, and `reviews` where `mod_state='approved'`.
- Auth users can `INSERT` into `reviews` as themselves; edit/delete for 15 min.
- Admin (JWT `role=admin`) can manage catalog/reviews/batches/inventory.