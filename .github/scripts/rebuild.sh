#!/usr/bin/env bash
set -euo pipefail

# Rebuild script for alovajs/alovajs.github.io
# Runs on existing source tree (no clone). Installs deps, runs pre-build steps, builds.

# --- Node version ---
if [ -f "$HOME/.nvm/nvm.sh" ]; then
    # shellcheck source=/dev/null
    source "$HOME/.nvm/nvm.sh"
    nvm install 20 --no-progress
    nvm use 20
fi

NODE_MAJOR=$(node --version | sed 's/v//' | cut -d. -f1)
if [ "$NODE_MAJOR" -lt 20 ]; then
    echo "[ERROR] Node $NODE_MAJOR detected; Node 20+ required for Docusaurus 3.9.x"
    exit 1
fi
echo "[INFO] Using $(node --version)"

# --- Package manager: npm ---
npm ci

# --- Build ---
npm run build

echo "[DONE] Build complete."
