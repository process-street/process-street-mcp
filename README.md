# Process Street MCP Server

Process Street's hosted Model Context Protocol server connects compatible AI clients to Process Street workflows, workflow runs, tasks, users, data sets, and operational records.

This repository contains the public discovery metadata for the hosted server. It does not contain the server implementation.

## Connect

Use this remote server URL in an MCP client:

```text
https://mcp.process.st/
```

The server uses Streamable HTTP. Compatible clients can use the interactive authorization flow. Process Street API keys can also be supplied as bearer tokens where the client supports custom authentication.

See the [Process Street MCP Server guide](https://www.process.st/help/docs/mcp-server/) for setup instructions for supported clients.

## Cursor plugin

This repository is also a [Cursor plugin](https://cursor.com/docs/plugins) for the Cursor Marketplace:

- [`.cursor-plugin/plugin.json`](.cursor-plugin/plugin.json) is the plugin manifest.
- [`mcp.json`](mcp.json) adds the hosted server at `https://mcp.process.st/`.
- [`assets/logo.svg`](assets/logo.svg) is the Marketplace logo.

After installing the plugin, Cursor shows the server as `plugin-process-street-process-street`. The first time it connects, Cursor opens the Process Street sign-in and consent screen. Cursor registers itself through Dynamic Client Registration, so no client ID or secret is needed. To revoke access later, go to Profile → Apps in Process Street.

To use it without the Marketplace, add the same entry to `~/.cursor/mcp.json` or a project's `.cursor/mcp.json`:

```json
{
  "mcpServers": {
    "process-street": {
      "url": "https://mcp.process.st/"
    }
  }
}
```

## Capabilities and access

The server exposes Process Street operations as MCP tools. Depending on the connected user's permissions, these tools can help an AI client:

- Find and work with workflows, workflow runs, tasks, users, and data sets
- Create and manage workflow runs and assigned tasks
- Produce reports and summaries from Process Street data
- Analyze operational records available to the connected user

Access remains subject to the user's Process Street permissions. Organizations that require SAML SSO are not currently supported by the documented MCP connection flow.

## Registry metadata

[`server.json`](server.json) is published in the [Official MCP Registry](https://modelcontextprotocol.io/registry/about) as `io.github.process-street/process-street-mcp` version `1.0.0`.

- [Official Registry API record, v0.1](https://registry.modelcontextprotocol.io/v0.1/servers?search=io.github.process-street%2Fprocess-street-mcp)
- [Official Registry API record, v0](https://registry.modelcontextprotocol.io/v0/servers?search=io.github.process-street%2Fprocess-street-mcp)

Published Registry versions are immutable. Any metadata correction must use a new unique version.

## Resources

- [MCP Server documentation](https://www.process.st/help/docs/mcp-server/)
- [Process Street Help Center](https://www.process.st/help/)
- [Security](https://www.process.st/security/)
- [Privacy policy](https://www.process.st/privacy/)
- [Terms of service](https://www.process.st/terms/)
- [Contact Process Street](https://www.process.st/contact/)

## Repository scope

Issues and pull requests in this repository should concern public discovery metadata or its documentation. Product support and security matters should use the official resources above.
