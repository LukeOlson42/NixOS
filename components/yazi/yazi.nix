{ config, lib, pkgs, ... }:

{
	programs.yazi = {
		enable = true;
        enableZshIntegration = true;
        settings = {
            plugins = {
                # add smart enter if i get around to it
            };

            open = {
                prepend_rules = [
                    { name = "*.pdf"; use = "pdf"; }
                ];
            };

            opener = {
                edit = [
                    {
                        run = "alacritty -e nvim $@";
                        orphan = true;
                        for = "unix";
                    }
                ];
                pdf = [
                    {
                        run = "sioyek $@";
                        orphan = true;
                        for = "unix";
                    }
                ];
            };

        };
	};
}
