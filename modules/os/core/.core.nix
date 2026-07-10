# Core OS module aggregator.
#
# This file does not define system behavior directly. It imports the base
# operating-system modules so host configurations can include the complete
# core system layer through a single entrypoint.

{
  imports = [
    ./boot.nix
	./bluetooth.nix
    ./locale.nix
    ./networking.nix
    ./printing.nix
    ./sound.nix
    ./users.nix
	./power.nix
	./gen-clean.nix
	./zsh.nix
  ];
}
