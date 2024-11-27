#! /usr/bin/env bash

set -a
dir=$(pwd)

echo ${dir}

home-manager switch --flake ${dir}/#lukeolson@nixos-desktop --show-trace
