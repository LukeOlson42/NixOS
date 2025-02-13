#! /usr/bin/env bash

set -a
dir=$(pwd)

echo ${dir}

sudo nixos-rebuild switch --flake ${dir}/#main-desktop --show-trace --impure --upgrade
