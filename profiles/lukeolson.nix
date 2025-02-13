{ config, pkgs, ... }:

{
	users = {
        groups = {
            docker = {
                members = [ "lukeolson" ];
            };
        };
        users.lukeolson = {
            isNormalUser = true;
            description = "Luke";
            extraGroups = [ "networkmanager" "wheel" "docker" ];
        };
	};
}
