# Publishing and release checklist

Registry publication changes public systems and must be explicitly approved before a new version is released.

## Public repository and Registry record

- GitHub organization: `process-street`
- Repository: `process-street-mcp`
- Visibility: public
- Registry server name: `st.process/mcp`, published with DNS authentication on `process.st`
- First version under this name: `1.0.0`
- Previous name: `io.github.process-street/process-street-mcp` (`1.0.0`, GitHub authentication). See [Moving from the GitHub namespace](#moving-from-the-github-namespace).

This metadata-only repository is separate from the existing private `process-street/mcp-server` implementation repository. Do not copy private server code, infrastructure configuration, secrets, customer information, or internal documentation into this repository.

## Registry authentication

The server is published with the Registry's [DNS authentication](https://modelcontextprotocol.io/registry/authentication#dns-authentication) on `process.st`. That proves ownership of the domain, which is what lets the server use a name in the `st.process` namespace rather than one tied to a GitHub organization.

- A TXT record on the apex of `process.st` holds the public key: `v=MCPv1; k=ed25519; p=<base64 public key>`. It must be on `process.st` itself. The Registry does not look at a subdomain such as `_mcp-auth.process.st`.
- The matching Ed25519 private key is kept in Process Street's password manager. Never commit it or type it into a shell. `mcp-publisher` reads it from the `MCP_PRIVATE_KEY` environment variable, and `.gitignore` excludes `*.pem`, `*.key` and `*.hex`.
- Anyone holding the private key can publish under `st.process`. If the key may have leaked, remove its TXT record immediately, which stops new logins, then set up a new key.

### Setting up or rotating the key

Ed25519 needs OpenSSL 3. The `openssl` that ships with macOS is LibreSSL and fails with `Algorithm Ed25519 not found`, so use an OpenSSL 3 build there.

```bash
openssl genpkey -algorithm Ed25519 -out key.pem

# The TXT record value for process.st
echo "v=MCPv1; k=ed25519; p=$(openssl pkey -in key.pem -pubout -outform DER | tail -c 32 | base64)"

# The hex private key that mcp-publisher expects
openssl pkey -in key.pem -noout -text | sed -n '/priv:/,/pub:/p' | sed '1d;$d' | tr -d ' :\n' > key.hex
```

1. Save the contents of `key.hex` in the password manager, then delete `key.pem` and `key.hex`.
2. Add the TXT record to the `process.st` zone, keeping any other TXT records there.
3. Once it has propagated, confirm it is visible: `dig TXT process.st +short | grep MCPv1`.
4. When rotating, add the new record next to the old one, confirm that login works with the new key, then remove the old record. An old record left in place keeps the old key valid.

### Logging in

With the hex private key in `MCP_PRIVATE_KEY` (load it from the password manager, for example with `op run`):

```bash
mcp-publisher login dns --domain process.st
```

The command prints the `Expected proof record` for the key. If login fails, compare it with the record that `dig TXT process.st +short` returns.

## Future release gate

1. Use a new unique semantic version in `server.json`. Published Registry versions are immutable.
2. Re-run `./scripts/validate.sh` and review every tracked file and commit for sensitive information.
3. Confirm the repository, remote endpoint, documentation, support, privacy, and security links are still public and accurate.
4. Obtain explicit approval for the exact `server.json` payload and version.
5. Push the reviewed repository commit.
6. Authenticate `mcp-publisher` with DNS authentication on `process.st`, as in [Logging in](#logging-in).
7. Publish `server.json` and verify the exact version through both Official MCP Registry API versions.
8. Update the distribution tracker and check downstream directories after they have had time to ingest the Registry. Do not assume a guaranteed ingestion interval.

Any metadata correction after publication requires a new unique version in `server.json`.

## Moving from the GitHub namespace

Version `1.0.0` was first published as `io.github.process-street/process-street-mcp`, using GitHub authentication. The Registry treats a new name as a separate server, so the move to `st.process/mcp` is a new listing followed by retiring the old one:

1. Add the TXT record and confirm that `mcp-publisher login dns --domain process.st` succeeds.
2. Publish `st.process/mcp` version `1.0.0` through the release gate above. The Registry allows both names to point at `https://mcp.process.st/` while the old one is retired.
3. Deprecate the old listing with a message that points to the new name. This needs GitHub authentication as an owner of the `process-street` organization: GitHub Actions OIDC, or `mcp-publisher login github --token` with a token that can read organization membership. The interactive `mcp-publisher login github` flow cannot act for an organization.

   ```bash
   mcp-publisher status --status deprecated --message "Moved to st.process/mcp" io.github.process-street/process-street-mcp 1.0.0
   ```

4. Update the distribution tracker. Directories that copied the old listing may show both names until they ingest the change.
