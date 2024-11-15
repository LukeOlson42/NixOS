{ config, pkgs, ... }:

let
    zshTheme = ''
        autoload -U colors && colors
        PROMPT='%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$fg[green]%} $%b '
    '';
in
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
            btop
		];
	};

    home.file.".oh-my-zsh/custom/themes/lukeolson.zsh-theme".text = zshTheme;

	programs.zsh = {
		enable = true;
		enableCompletion = true;
		shellAliases = {
			ls = "eza -l -s extension";
			cls = "clear";
		};

        dotDir = ".config/zsh";

		history = {
			size = 1000;
			path = "${config.xdg.dataHome}/zsh/history";
		};

        oh-my-zsh = {
            enable = true;
            theme = "lukeolson";
            custom = "${config.home.homeDirectory}/.oh-my-zsh/custom";
        };
	};

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

	programs.alacritty = {
		enable = true;
		settings = {
			font = {
				size = 12;
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

            mouse.bindings = [
                { "mouse" = "Right"; "action" = "Paste"; }
            ];

            cursor.style = "Block";

			shell.program = "zsh";
            window.opacity = 0.9;
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

    programs.tmux = {
        enable = true;
        shell = "~/.nix-profile/bin/zsh";
        mouse = true;
        extraConfig = ''
            unbind C-b
            set-option -g prefix C-a
            bind-key C-a send-prefix

            bind -n C-b split-window -h
            bind -n C-v split-window -v

            bind -n C-h select-pane -L
            bind -n C-j select-pane -D
            bind -n C-k select-pane -U
            bind -n C-l select-pane -R
        '';
    };
}
