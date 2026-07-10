{ pkgs, ... }:

{
	environment.systemPackages = with pkgs; [
		ghostty
		chromium
		wl-clipboard
		rofi
		swaynotificationcenter
		networkmanagerapplet
		wireplumber
		quickshell
		awww
		grim
		slurp
		swappy
		vlc
		localsend
		libreoffice
	];
}
