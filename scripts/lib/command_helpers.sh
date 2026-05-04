#!/usr/bin/env bash
set -euo pipefail

has_command() {
    command -v "$1" >/dev/null 2>&1
}
