# Compliance Notes — Cann-Grade MVP

## GDPR (high-level)
- **Lawful basis**: Explicit consent (consent_logs, versioned text)
- **Minimisation**: No unnecessary identifiers; public feed shows opinions only
- **Access/Erasure**: Route to export/delete upon request
- **Security**: RLS across tables; admin via JWT claim role=admin; audit of moderation

## Sensitive Data
- Reviews mentioning conditions = health data
- Mitigations: explicit consent, user-facing disclaimers, no medical advice

## Moderation
- Block medical claims/dosing advice; escalate flagged posts
- Immutable audit (review_audit) for governance

## DPIA Alignment (MVP)
- Risks: sensitive UGC, identity linkage
- Controls: consent, RLS, storage scoping, audit
- Residual risk: low for limited pilot with anonymised analytics
