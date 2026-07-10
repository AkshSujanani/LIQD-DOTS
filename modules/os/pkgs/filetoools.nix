{ pkgs, ... }:

{
	environment.systemPackages = with pkgs; [
		nemo
		yazi
		ntfs3g
	];
}
