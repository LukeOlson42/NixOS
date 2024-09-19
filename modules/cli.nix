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
			gcc
		];
	};

	programs.zsh = {
		enable = true;
		enableCompletion = true;

		shellAliases = {
			ls = "exa";
			cls = "clear";
		};

		history = {
			size = 1000;
			path = "${config.xdg.dataHome}/zsh/history";
		};

		oh-my-zsh = {
			enable = true;
			theme = "robbyrussell";
		};
	};

	programs.yazi = {
		enable = true;
        enableZshIntegration = true;
	};
    xdg.configFile."yazi/yazi.toml".source = ./yazi/theme.toml;

	programs.alacritty = {
		enable = true;
		settings = {
			font = {
				size = 10;
				normal.family = "Iosevka Nerd Font";
				bold.family = "Iosevka Nerd Font";
				italic.family = "Iosevka Nerd Font";
			};
            colors = {
                primary = {
                    background = "#282828";
                    foreground = "#ebdbb2";
                };

                normal = {
                    black = "#282828";
                    red = "#cc241d";
                    green = "#98971a";
                    yellow = "#d79921";
                    blue = "#458588";
                    magenta = "#b16286";
                    cyan = "#689d6a";
                    white = "#a89984";
                };

                bright = {
                    black = "#928374";
                    red = "#fb4934";
                    green = "#b8bb26";
                    yellow = "#fadb2f";
                    blue = "#83a598";
                    magenta = "#d3869b";
                    cyan = "#8ec07c";
                    white = "#ebebb2";
                };
            };

			shell.program = "zsh";
            window.opacity = 0.95;
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
