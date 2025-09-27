-- Top products by average stars (last 90 days)
SELECT sku, product_name, review_count_90d, avg_stars_90d
FROM product_rating_stats
ORDER BY avg_stars_90d DESC NULLS LAST
LIMIT 20;

-- Negative reviews last 30 days (for moderation/ops)
SELECT r.id, p.sku, p.product_name, r.stars, r.title, r.submitted_at
FROM reviews r
JOIN products p ON p.id = r.product_id
WHERE r.mod_state='approved' AND r.stars <= 2 AND r.submitted_at >= now() - interval '30 days'
ORDER BY r.submitted_at DESC;

-- Badge candidates
SELECT * FROM product_badges WHERE qualifies_for_badge = true ORDER BY avg_stars DESC;