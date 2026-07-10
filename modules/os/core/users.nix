{ pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."aksh" = {
    isNormalUser = true;
    description = "aksh";
	shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" ];
  };
}
