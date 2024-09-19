{ config, pkgs, ... }:

{
  home = {
	  username = "lukeolson";
	  homeDirectory = "/home/lukeolson";
	  # Don't change, check release notes if need to
	  stateVersion = "24.05"; # Please read the comment before changing.
  };

  nixpkgs.config.allowUnfree = true;

  imports = [
	./cli.nix
	./neovim/nvim.nix
	./hyprland.nix
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
