#! /usr/bin/env bash

set -a
dir=$(pwd)

echo ${dir}

sudo nixos-rebuild switch --flake ${dir}/#mainDesktop --show-trace
