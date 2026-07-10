#!/usr/bin/env bash

mkdir -p "$HOME/Pictures/Screenshot"
grim -g "$(slurp)" - | swappy -f -
