# Publishing and release checklist

Registry publication changes public systems and must be explicitly approved before a new version is released.

## Public repository and Registry record

- GitHub organization: `process-street`
- Repository: `process-street-mcp`
- Visibility: public
- Registry server name: `io.github.process-street/process-street-mcp`
- Published version: `1.0.0`

This metadata-only repository is separate from the existing private `process-street/mcp-server` implementation repository. Do not copy private server code, infrastructure configuration, secrets, customer information, or internal documentation into this repository.

## Future release gate

1. Use a new unique semantic version in `server.json`. Published Registry versions are immutable.
2. Re-run `./scripts/validate.sh` and review every tracked file and commit for sensitive information.
3. Confirm the repository, remote endpoint, documentation, support, privacy, and security links are still public and accurate.
4. Obtain explicit approval for the exact `server.json` payload and version.
5. Push the reviewed repository commit.
6. Authenticate `mcp-publisher` with a GitHub identity authorized for the `process-street` organization.
7. Publish `server.json` and verify the exact version through both Official MCP Registry API versions.
8. Update the distribution tracker and check downstream directories after they have had time to ingest the Registry. Do not assume a guaranteed ingestion interval.

Any metadata correction after publication requires a new unique version in `server.json`.
