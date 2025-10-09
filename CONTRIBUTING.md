# Contributing to Cann-Grade MVP

Thank you for contributing to this project! Please follow the guidelines below to ensure smooth development and deployment processes.

## Branch → Environment Flow

We use a structured branching strategy that maps to different environments:

- **`feature/*` branches** → DEV environment
  - Create feature branches from `develop` for all new work
  - Use descriptive names: `feature/user-authentication`, `feature/review-upload`, etc.
  - These are used for local development and testing

- **`develop` branch** → STAGING environment
  - Integration branch for completed features
  - All feature branches should be merged here via pull request
  - Used for pre-production testing and QA

- **`main` branch** → PRODUCTION environment
  - Production-ready code only
  - Merged from `develop` after successful staging validation
  - Protected branch with strict merge requirements

## Database Migrations

We use Supabase for our database. All schema changes must be tracked:

1. Make schema changes in your local Supabase instance
2. Generate migration files using:
   ```bash
   supabase db diff -f <migration_name>
   ```
3. Review the generated migration file in `db/migrations/`
4. Include migration files in your pull request
5. Document the migration in your PR description

**Important:** Never modify the database schema directly in staging or production. All changes must go through migration files.

## Secrets and Environment Variables

- **NEVER commit secrets or API keys to git**
- Use `.env.example` as a template for required environment variables
- Store actual secrets in:
  - Local: `.env` file (gitignored)
  - Vercel/deployment: Environment variables in project settings
  - Supabase: Project settings → API keys

## Pull Request Process

1. Create your feature branch from `develop`
2. Make your changes with clear, focused commits
3. Update relevant documentation:
   - `CHANGELOG.md` - Add entry under "Unreleased"
   - `docs/TRACEABILITY.md` - Link requirements to implementation
   - Add/update tests for your changes
4. Create a pull request targeting `develop`
5. Ensure all CI checks pass (install, typecheck, lint, tests)
6. Request review from a team member
7. Address any feedback and re-request review
8. Once approved, squash and merge into `develop`

## Code Quality

- Follow TypeScript best practices
- Run `npm run typecheck` before committing
- Run `npm run lint` and fix any issues
- Write tests for new functionality
- Keep functions small and focused
- Use meaningful variable and function names

## Commit Messages

Use conventional commit format:
```
type(scope): description

[optional body]

[optional footer]
```

Types: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`

Examples:
- `feat(auth): add user login functionality`
- `fix(reviews): correct photo upload validation`
- `docs(readme): update installation instructions`

## Questions?

If you have questions about contributing, please open an issue or reach out to the team.
