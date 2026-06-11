#!/usr/bin/env bash
set -euo pipefail

cat >&2 <<'EOF'
sync-into-nikechan-x.sh is deprecated and intentionally disabled.

The canonical production source for Another World is now the nikechan-x
Hermes gateway repository. Make changes directly in /opt/nikechan-x and
commit them to git@github.com:tegnike/nikechan-x.git.
EOF

exit 1
