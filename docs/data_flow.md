# Data Flow — Cann-Grade MVP

1) **Sign-up & Consent**
   - profile row created (profiles)
   - consent recorded (consent_logs: version=text)

2) **Submit Review**
   - reviews(product_id, batch_id?, author_id, stars, title, body, consent_version)
   - optional photo to Storage (review-photos), URL saved in reviews.photo_url

3) **Moderation**
   - mod_state: pending → approved/rejected
   - review_audit logs transitions (who/when/reason)

4) **Public Feed**
   - RLS exposes only approved reviews
   - No PII displayed

5) **Clinic Insights**
   - product_rating_stats & product_badges views feed Retool
   - CSV export for ops
