# Moderation Policy (MVP)

## Principles
- Patient opinions only; no medical advice or claims.
- Respectful language; no harassment; no hate speech.
- No dosing guidance, diagnosis, or treatment recommendations.

## Blocked / Flagged Keywords (example)
- "cured", "diagnosed with", "prescribe me", "dosage", "mg/ml" (contextual)
- Brand advertising CTAs (e.g., "buy now", links to purchase)

## Workflow
1. New reviews default to `pending` if keyword flagged; otherwise `approved`.
2. Admin reviews pending items in queue; edits not permitted (approve/reject only).
3. All moderation actions are logged in `review_audit`.

## Takedown
- Illegal content, personal data, or threats → immediate removal and log reason.
