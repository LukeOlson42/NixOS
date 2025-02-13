{ inputs, pkgs, user, config, lib, ... }:
{
    imports = [
        ../../profiles/${user}.nix
    ];

    environment.systemPackages = with pkgs; [
        btop
        traceroute
    ];
}
