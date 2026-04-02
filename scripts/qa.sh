#!/usr/bin/env bash
set -euo pipefail

echo "==> ruff format check"
uv run ruff format . --check

echo "==> ruff lint"
uv run ruff check .

echo "==> mypy"
uv run mypy src tests

echo "==> pytest"
uv run pytest

echo "==> bandit"
uv run bandit -r src -x tests

echo "==> pip-audit"
uv run pip-audit

echo "==> all checks passed"
