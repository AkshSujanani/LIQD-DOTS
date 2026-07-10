{ pkgs, ... }:

{
# Programming languages available system-wide

# These programming and available system-wide and can 
# be changed according to developer needs

	environment.systemPackages = with pkgs; [
		gcc
		cmake
		gnumake
		python314
		python314Packages.pip
		tree-sitter
		nodejs
# Language servers for neovim 
		lua-language-server
		pyright
		bash-language-server
		clang-tools	
		nil
		vscode-langservers-extracted
	];
}
