#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
manifest="$repo_dir/server.json"
registry_validate_url="https://registry.modelcontextprotocol.io/v0.1/validate"

python3 - "$manifest" <<'PY'
import json
import pathlib
import re
import sys

path = pathlib.Path(sys.argv[1])
data = json.loads(path.read_text())

required = {"$schema", "name", "description", "version"}
missing = sorted(required - data.keys())
if missing:
    raise SystemExit(f"Missing required fields: {', '.join(missing)}")

if not re.fullmatch(r"[a-zA-Z0-9.-]+/[a-zA-Z0-9._-]+", data["name"]):
    raise SystemExit("Invalid Registry server name")
if len(data["description"]) > 100:
    raise SystemExit("Description exceeds the Registry's 100-character limit")
if data.get("remotes") != [{"type": "streamable-http", "url": "https://mcp.process.st/"}]:
    raise SystemExit("Unexpected remote transport configuration")
if path.stat().st_size > 4096:
    raise SystemExit("server.json exceeds the Registry's 4 KB limit")

print("Local manifest checks passed")
PY

validation_response="$(curl --fail --silent --show-error \
  --request POST \
  --header 'Content-Type: application/json' \
  --data-binary "@$manifest" \
  "$registry_validate_url")"

python3 - "$validation_response" <<'PY'
import json
import sys

result = json.loads(sys.argv[1])
if result.get("valid") is not True:
    raise SystemExit(f"Registry validation failed: {json.dumps(result, indent=2)}")
print("Official MCP Registry validation passed")
PY

urls=(
  "https://mcp.process.st/.well-known/oauth-protected-resource"
  "https://www.process.st/help/docs/mcp-server/"
  "https://www.process.st/help/"
  "https://www.process.st/security/"
  "https://www.process.st/privacy/"
  "https://www.process.st/terms/"
  "https://www.process.st/contact/"
  "https://modelcontextprotocol.io/registry/about"
)

for url in "${urls[@]}"; do
  curl --fail --silent --show-error --location --output /dev/null "$url"
done

echo "Public resource checks passed"
