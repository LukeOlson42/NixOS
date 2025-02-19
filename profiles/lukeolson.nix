{ inputs, config, pkgs, username, ... }:

{
    home = {
        inherit username;
        homeDirectory = "/home/${username}";
        # Don't change, check release notes if need to
        stateVersion = "24.11"; # Please read the comment before changing.
    };

    nixpkgs.config.allowUnfree = true;

    imports = [
        ../components/common
        ../components/alacritty
        ../components/hyprland
        ../components/neovim
        ../components/sioyek
        ../components/zsh
        ../components/firefox
    ];

    programs.home-manager.enable = true;
}
