{ pkgs, ... }:

{
# System-wide font configuration.
#
# These fonts are installed globally so terminals, editors, status bars,
# launchers, and desktop applications can share the same typography.
# Nerd Fonts are included for icon support in tools such as Neovim,
# Waybar, terminal prompts, and file managers.

	fonts.fontconfig.enable = true;
	fonts.packages = with pkgs; [
		nerd-fonts.jetbrains-mono
		nerd-fonts.caskaydia-cove
	];
}
