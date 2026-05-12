#!/bin/bash
set -euo pipefail

# Grace Evangelical Church site is a single-file static HTML site with
# no build step, no package manager, and no test/lint suite. This hook
# verifies the expected files are present and exposes a preview command.

if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

cd "$CLAUDE_PROJECT_DIR"

missing=0
for f in index.html favicon.svg grace-church-logo.svg; do
  if [ ! -f "$f" ]; then
    echo "warning: expected file missing: $f" >&2
    missing=1
  fi
done

if [ "$missing" -eq 0 ]; then
  echo "Grace-site static assets present."
fi

# Make a local preview command available for the session.
echo 'alias serve="python3 -m http.server 8000"' >> "$CLAUDE_ENV_FILE"
