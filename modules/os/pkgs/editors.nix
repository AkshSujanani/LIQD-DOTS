{ pkgs, ... }:

{
# Text editors, IDE's available system-wide

# This file by default contains only neovim
# Editors like vscode, vim can be easily added
# By taking refrence package form nix-pkg-search

	environment.systemPackages = with pkgs; [
		neovim

		# Note taking
		obsidian
	];
}
