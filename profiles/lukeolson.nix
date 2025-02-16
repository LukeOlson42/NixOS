{ inputs, config, pkgs, ... }:

{
    home = {
        username = "lukeolson";
        homeDirectory = "/home/lukeolson";
        # Don't change, check release notes if need to
        stateVersion = "24.11"; # Please read the comment before changing.
    };

    nixpkgs.config.allowUnfree = true;

    imports = [
        inputs.textfox.homeManagerModules.default
        ../components/common/common.nix 
        ../components/alacritty/alacritty.nix 
        ../components/hyprland/hyprland.nix 
        ../components/neovim/neovim.nix 
        ../components/sioyek/sioyek.nix 
        ../components/zsh/zsh.nix 
        ../components/firefox/firefox.nix 
    ];

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
}
