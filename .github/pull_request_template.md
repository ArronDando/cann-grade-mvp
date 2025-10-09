## Description

Please include a summary of the changes and the related issue. Include relevant motivation and context.

Fixes # (issue)

## Type of Change

Please delete options that are not relevant.

- [ ] Bug fix (non-breaking change which fixes an issue)
- [ ] New feature (non-breaking change which adds functionality)
- [ ] Breaking change (fix or feature that would cause existing functionality to not work as expected)
- [ ] Documentation update
- [ ] Refactoring (no functional changes)
- [ ] Performance improvement
- [ ] Database migration

## Checklist

Please ensure you have completed the following:

### Documentation
- [ ] I have updated the `CHANGELOG.md` file under the "Unreleased" section
- [ ] I have updated `docs/TRACEABILITY.md` with requirement mappings (if applicable)
- [ ] I have added/updated comments in complex code sections
- [ ] I have updated relevant documentation (README, API docs, etc.)

### Testing
- [ ] I have added tests that prove my fix is effective or that my feature works
- [ ] New and existing unit tests pass locally with my changes
- [ ] I have tested this change manually in my local environment
- [ ] I have checked for any console errors or warnings

### Code Quality
- [ ] My code follows the style guidelines of this project
- [ ] I have performed a self-review of my own code
- [ ] I have run `npm run typecheck` and fixed any type errors
- [ ] I have run `npm run lint` and fixed any linting issues
- [ ] My changes generate no new warnings

### Database Changes (if applicable)
- [ ] I have created migration files using `supabase db diff`
- [ ] Migration files are included in this PR
- [ ] I have tested the migration up and down locally
- [ ] I have documented the migration in the PR description

### Security
- [ ] I have not committed any secrets, API keys, or sensitive data
- [ ] I have checked that environment variables are properly configured
- [ ] I have considered security implications of my changes

## Screenshots (if applicable)

Add screenshots to help explain your changes.

## Additional Notes

Add any other context about the pull request here.

## Related PRs

List any related pull requests:
- #

## Deployment Notes

Note anything that needs to be done during deployment:
- Environment variables that need to be added/updated
- Manual steps required after deployment
- Dependencies on other systems or services
