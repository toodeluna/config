#!/usr/bin/env sh

set -e

locker
nix flake check
