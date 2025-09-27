# System Architecture — Cann-Grade MVP

## Overview
The MVP captures patient reviews of prescribed cannabis products, enforces consent & moderation, and surfaces insights to clinics.

## Components
- **Database (Supabase / Postgres)**
  - Tables: profiles, products, batches, reviews, consent_logs
  - Views: product_rating_stats, product_badges
  - RLS: public read of products/batches/approved reviews; role=admin for management

- **Patient App (Bubble/FlutterFlow)**
  - Flow: sign-up → consent → submit review → feed
  - Storage: review-photos bucket

- **Moderation**
  - Reviews default pending if flagged; otherwise approved
  - Audit trail logs state changes

- **Clinic Dashboard (Retool)**
  - KPIs: avg rating, review_count, recent negatives
  - Exports: CSV for ops/investor reporting

## Diagram
[Patient] → [Consent & Review Form] → [Supabase DB] → [Moderation Queue] → [Clinic Dashboard]
