#!/bin/bash
# setup-git.sh — Run this ONCE from Terminal to initialise the repo and push.
# Usage: bash "/Users/james/Claude/market-research-dashboard/setup-git.sh"

DEPLOY_DIR="$(cd "$(dirname "$0")" && pwd)"
SOURCE="$(dirname "$DEPLOY_DIR")/Supply chain research dashboard/2026-04-19-supply-chain-dashboard.html"

cd "$DEPLOY_DIR" || exit 1

echo "→ Copying latest dashboard..."
cp "$SOURCE" "$DEPLOY_DIR/index.html"

echo "→ Initialising git repo..."
git init
git branch -M main
git add .
git commit -m "Initial deploy: Company and Market Research Dashboard"

echo "→ Adding remote..."
git remote remove origin 2>/dev/null
git remote add origin https://github.com/codemaster518/market-research-dashboard.git

echo "→ Pushing to GitHub..."
git push -u origin main

echo ""
echo "✓ Done! Your dashboard is now on GitHub."
echo "  Next: enable GitHub Pages at:"
echo "  https://github.com/codemaster518/market-research-dashboard/settings/pages"
echo "  Set Source → Deploy from branch → main → / (root) → Save"
echo ""
echo "  Your live URL will be:"
echo "  https://codemaster518.github.io/market-research-dashboard/"
