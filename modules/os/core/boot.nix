{ pkgs, ... }:

{
  # Bootloader.
  boot.loader.systemd-boot.enable = false;
  boot.loader.grub = {
  	enable = true;
	efiSupport = true;
	device = "nodev";
	configurationLimit = 5;
  };
  boot.loader.efi.canTouchEfiVariables = false;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;
}
