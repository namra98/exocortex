# Auth Token Refresh Patterns

**Status**: active
**Created**: 2026-02-03

## Core Idea

Investigate different patterns for handling auth token refresh in SPAs — silent refresh vs. refresh token rotation vs. sliding sessions. Current implementation uses a basic refresh token but there may be better approaches for our use case.

## Research So Far

- Silent refresh (iframe-based) is being deprecated by browsers due to third-party cookie restrictions
- Refresh token rotation adds complexity but improves security
- Backend-for-frontend (BFF) pattern avoids token exposure entirely

## Next Steps

- [ ] Prototype BFF pattern with our existing auth service
- [ ] Benchmark latency impact of refresh token rotation
- [ ] Review OWASP recommendations for token storage

## Related

- See daily logs 2026-02-03, 2026-02-04 for implementation progress
