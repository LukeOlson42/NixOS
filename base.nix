{ inputs, config, pkgs, ... }:
let 
    timezone = "America/New_York";
in
{
	time.timeZone = timezone;

    nix.settings.experimental-features = ["nix-command" "flakes"];

    environment.systemPackages = with pkgs; [
        git
    ];

    # users = {
    #     mutableUsers = false;
    # };

	nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 21d";
    };

    nixpkgs.config.allowUnfree = true;

    system.stateVersion = "24.11";
}
