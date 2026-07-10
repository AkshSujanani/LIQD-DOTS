{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
	hyprland.url = "github:hyprwm/Hyprland";
	# Add the tmux plugin
    tmux-nerd-font-window-name.url = "github:joshmedeski/tmux-nerd-font-window-name";
    tmux-nerd-font-window-name.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
	nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
		system = "x86_64-linux";
		specialArgs = { inherit inputs; };
		modules = [ 
			./hosts/default/configuration.nix 
		];
	};
  };
}
