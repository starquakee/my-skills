#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd -- "${SCRIPT_DIR}/../.." && pwd)"
cd "$REPO_ROOT"

echo "Error: final validation has not been configured." >&2
echo "Replace this message and exit with the PRD's final aggregate validation commands." >&2
exit 2

# Examples:
# npm run typecheck
# npm test
# npm run build
# npm run test:e2e
