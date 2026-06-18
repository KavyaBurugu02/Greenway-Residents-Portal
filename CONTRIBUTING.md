# Contributing

Thanks for taking the time to look at this project.

## Reporting issues

Open a GitHub Issue with:
- What you were doing
- What you expected to happen
- What actually happened
- Your Java version, Tomcat version, and OS

## Making changes

1. Fork the repository and create a branch from `main`.
2. Follow the setup steps in the README to get the application running locally.
3. Keep changes focused — one logical change per pull request.
4. Test manually before submitting (login, sign up, raise a complaint, admin status update).
5. Open a pull request with a short description of what changed and why.

## Code style

- Standard Java conventions — no tabs, 4-space indent.
- Keep DAO classes thin: one public method per operation, no business logic.
- JSP scriptlets are intentional here (no JSTL dependency), but keep them short.
- No commented-out code in pull requests.

## Things that would be genuinely useful

- Password hashing (BCrypt via jBCrypt)
- Pagination on complaint tables
- JSTL replacement for scriptlets
- Any bug you find in the session/redirect flow
