#!/bin/bash
# sync-and-push.sh
# Copies the latest dashboard and pushes to GitHub if anything changed.
# Run manually, or installed as a LaunchAgent for automatic pushes.

DEPLOY_DIR="$(cd "$(dirname "$0")" && pwd)"
SOURCE="$(dirname "$DEPLOY_DIR")/Supply chain research dashboard/2026-04-19-supply-chain-dashboard.html"
LOG="$DEPLOY_DIR/auto-push.log"

cd "$DEPLOY_DIR" || exit 1

# Sync latest dashboard file
cp "$SOURCE" "$DEPLOY_DIR/index.html"

# Only push if something actually changed
if git diff --quiet && git diff --cached --quiet; then
  echo "$(date '+%Y-%m-%d %H:%M:%S') — No changes, skipping push." >> "$LOG"
  exit 0
fi

git add index.html
git commit -m "Dashboard update — $(date '+%Y-%m-%d %H:%M')"

if git push origin main >> "$LOG" 2>&1; then
  echo "$(date '+%Y-%m-%d %H:%M:%S') — Pushed to GitHub successfully." >> "$LOG"
else
  echo "$(date '+%Y-%m-%d %H:%M:%S') — Push failed. Check log above." >> "$LOG"
fi
