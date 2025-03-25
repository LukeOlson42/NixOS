{ config, lib, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        # For Steam
        mangohud
        protonup

        pipewire
        wireplumber
        vesktop

        # For Spotify
        spotify
        playerctl

        # For Miscellaneous
        r2modman
        linuxKernel.packages.linux_xanmod_stable.xpadneo
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
