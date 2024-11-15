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
        ../components/common/common.nix 
        ../components/alacritty/alacritty.nix 
        ../components/hyprland/hyprland.nix 
        ../components/neovim/neovim.nix 
        ../components/yazi/yazi.nix 
        ../components/sioyek/sioyek.nix 
        ../components/zsh/zsh.nix 
    ];

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
}
