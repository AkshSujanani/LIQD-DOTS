{ pkgs, ... }:

{
	environment.systemPackages = with pkgs; [
		wireshark	
		nmap
	];
}
