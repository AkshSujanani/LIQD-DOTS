#!/usr/bin/env bash

# 1. Delete all system generations except the current one
sudo nix-collect-garbage -d

# 2. Update your bootloader menu to remove entries for the deleted generations
sudo /run/current-system/bin/switch-to-configuration boot

