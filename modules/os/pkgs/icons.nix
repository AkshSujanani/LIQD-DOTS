{ pkgs, ... }:

{
	environment.systemPackages = with pkgs; [
		papirus-icon-theme
		adwaita-icon-theme
	];
}
