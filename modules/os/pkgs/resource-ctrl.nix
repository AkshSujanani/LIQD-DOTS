{ pkgs, ... }:

{
	environment.systemPackages = with pkgs; [
		brightnessctl
		playerctl
		libnotify			# API for notifications used by swaync optional eventhough
	];
}
