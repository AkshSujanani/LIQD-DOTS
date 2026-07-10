{inputs, pkgs, ...}: 

{
  imports = [
  	./rofi.nix
	./liqd-shell.nix
  ];
  services.displayManager.ly = {
	  enable = true;
	  settings = {
		  animate = true;
		  animation = 1;
	  };
  };
  programs.hyprland = {
    enable = true;
    # set the flake package
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    # make sure to also set the portal package, so that they are in sync
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };
  programs.kdeconnect.enable = true;
  programs.hyprlock.enable = true;
  services.hypridle.enable = true;

  security.pam.services.hyprlock = {};

  environment.etc."xdg/hypr".source = ../../../configs/hypr;
}
