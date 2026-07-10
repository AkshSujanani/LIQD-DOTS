{ pkgs, ... }:

{
# General command-line tools available system-wide

# These tools are not tied to a specific dekstop environment,
# programming language, or use workflow

	environment.systemPackages = with pkgs; [
		bash		# Shell
		btop		# System monitor
		curl		
		fastfetch	# System information display
		git			# Version control
		lazygit		# Popular TUI for git
		tree		# Directory tree viewer
		unzip		# Extract .zip archives
		zip			# Create .zip archives
		bat
		bluetui
		sl
		tmux
		cava
		codex
	];
}
