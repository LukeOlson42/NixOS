{ pkgs, ... }:

{
    services.gvfs.enable = true;
    environment.systemPackages = with pkgs; [
        nemo-with-extensions
        nemo-emblems
        nemo-fileroller
        folder-color-switcher
    ];
}
