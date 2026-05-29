{ config, lib, pkgs, ... }:
{
    environment.systemPackages = with pkgs; [
        ardour_8
        guitarix-vst
        audacity
        dexed
    ];
}
