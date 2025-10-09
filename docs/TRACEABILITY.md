# Traceability Matrix

This document maps requirements (User Stories, Functional Requirements, and Non-Functional Requirements) to their implementation in code, database migrations, and tests.

## How to Use This Document

- **ID Format:**
  - `US-###` - User Stories
  - `FR-###` - Functional Requirements
  - `NFR-###` - Non-Functional Requirements

- **Update this file** when:
  - Implementing a new feature
  - Adding database migrations
  - Writing tests
  - Making changes that affect requirements

## Traceability Table

| Requirement ID | Description | Implementation (Code) | Migrations | Tests | Status |
|----------------|-------------|----------------------|------------|-------|--------|
| US-001 | Example: User can submit a review | `dashboard/src/components/ReviewForm.tsx` | `20231201_create_reviews.sql` | `ReviewForm.test.tsx` | ✅ Complete |
| FR-001 | Example: Review validation rules | `dashboard/src/lib/validation.ts` | - | `validation.test.ts` | ✅ Complete |
| NFR-001 | Example: Response time < 200ms | `dashboard/src/api/reviews.ts` | - | `performance.test.ts` | 🔄 In Progress |

## Template for New Entries

When adding a new requirement, copy this template:

```markdown
| [ID] | [Brief description] | [File paths] | [Migration files] | [Test files] | [Status] |
```

**Status Options:**
- ✅ Complete - Implementation finished and tested
- 🔄 In Progress - Currently being worked on
- ⏳ Planned - Scheduled for implementation
- ❌ Blocked - Cannot proceed due to dependencies

## Requirements Coverage

This section will be updated as requirements are added:

- **User Stories:** 1/1 (100%)
- **Functional Requirements:** 1/1 (100%)
- **Non-Functional Requirements:** 0/1 (0%)

## Notes

- Keep this document up to date with every PR that implements or modifies requirements
- Link to this document in your pull request descriptions
- Use this to verify test coverage for each requirement
- Cross-reference with CHANGELOG.md for release notes
