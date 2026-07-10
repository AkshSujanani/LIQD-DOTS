{
# Package module aggregator.

# This file does not declare packages directly. It imports grouped package
# modules so the host configuration can include the complete system package
# set through a single entrypoint.
  imports = [
    ./cli.nix
    ./dev.nix
    ./editors.nix
    ./fonts.nix
	./sys-apps.nix
	./filetoools.nix
	./icons.nix
	./resource-ctrl.nix
	./htools.nix
	./tmux.nix
	./web-apps.nix
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
}
