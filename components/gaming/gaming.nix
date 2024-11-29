{ config, lib, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        mangohud
        protonup
        discord
        r2modman
        spotube
    ];

    # Steam Setup
    programs.gamemode.enable = true;
    programs.steam = {
        enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
        localNetworkGameTransfers.openFirewall = true;
        gamescopeSession.enable = true;
    };

    environment.sessionVariables = {
        STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
    };
}
