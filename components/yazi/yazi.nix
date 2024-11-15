{ config, lib, pkgs, ... }:

{
	programs.yazi = {
		enable = true;
        enableZshIntegration = true;
        settings = {
            opener = {
                edit = [
                    {
                        run = "alacritty -e nvim $@";
                        orphan = true;
                        for = "unix";
                    }
                ];
            };
        };
	};
}
