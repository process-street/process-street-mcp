# Publishing checklist

Publication changes public systems and must be explicitly approved before these steps are run.

## Proposed public repository

- GitHub organization: `process-street`
- Repository: `process-street-mcp`
- Visibility: public
- Registry server name: `io.github.process-street/process-street-mcp`

The proposed name does not conflict with the existing private `process-street/mcp-server` repository. Do not copy private server code, infrastructure configuration, secrets, or internal documentation into this repository.

## Release gate

1. Confirm authorization to create the public repository in the `process-street` organization.
2. Re-run `./scripts/validate.sh` and review every file for sensitive information.
3. Create the public repository only after approval of the exact account, name, and visibility above.
4. Push the reviewed local commit.
5. Authenticate the official `mcp-publisher` CLI with a GitHub identity authorized for the `process-street` organization.
6. Validate and publish `server.json`.
7. Verify the exact version in both Official MCP Registry API versions and the Registry website.
8. Add the published Registry URL and timestamp to the distribution tracker and operational task.
9. Check downstream directories after they have had time to ingest the Registry. Do not assume a guaranteed ingestion interval.

Any metadata correction after publication requires a new unique version in `server.json`.
