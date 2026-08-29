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

## Capabilities and access

The server exposes Process Street operations as MCP tools. Depending on the connected user's permissions, these tools can help an AI client:

- Find and work with workflows, workflow runs, tasks, users, and data sets
- Create and manage workflow runs and assigned tasks
- Produce reports and summaries from Process Street data
- Analyze operational records available to the connected user

Access remains subject to the user's Process Street permissions. Organizations that require SAML SSO are not currently supported by the documented MCP connection flow.

## Registry metadata

[`server.json`](server.json) is prepared for the [Official MCP Registry](https://modelcontextprotocol.io/registry/about). Registry publication is intentionally handled as a separate, reviewed release step because published versions are immutable.

## Resources

- [MCP Server documentation](https://www.process.st/help/docs/mcp-server/)
- [Process Street Help Center](https://www.process.st/help/)
- [Security](https://www.process.st/security/)
- [Privacy policy](https://www.process.st/privacy/)
- [Terms of service](https://www.process.st/terms/)
- [Contact Process Street](https://www.process.st/contact/)

## Repository scope

Issues and pull requests in this repository should concern public discovery metadata or its documentation. Product support and security matters should use the official resources above.
