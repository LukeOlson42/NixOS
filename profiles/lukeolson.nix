{ inputs, config, pkgs, username, ... }:

{
    programs.home-manager.enable = true;

    home = {
        inherit username;
        homeDirectory = "/home/${username}";
        # Don't change, check release notes if need to
        stateVersion = "24.11"; # Please read the comment before changing.
    };

    nixpkgs.config.allowUnfree = true;

    imports = [
        ../components/common/common.nix 
        ../components/alacritty/alacritty.nix 
        ../components/hyprland/hyprland.nix 
        ../components/neovim/neovim.nix 
        ../components/sioyek/sioyek.nix 
        ../components/zsh/zsh.nix 
        ../components/firefox/firefox.nix 
    ];
}
