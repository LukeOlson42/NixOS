{ config, pkgs, ... }:
{
	home = {
		packages = with pkgs; [
			wget
			unzip

			# Eza - ls replacement
			eza
			# TLDR
			tealdeer
			neofetch
            xclip

            # GCC, just in case ;)
            gcc 
            cowsay
		];
	};

    programs.btop = {
        enable = true;
        settings = {
            vim_keys = true;
            color_theme = "gruvbox_dark_v2";
        };
    };

    programs.git = {
        enable = true;
        userEmail = "olsonluke42@gmail.com";
        userName = "Luke Olson";
    };

    programs.ssh = {
        enable = true;
    };
}
