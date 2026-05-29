{ config, lib, pkgs, ... }:

{
	home = {
		packages = with pkgs; [
			wget
			unzip

			# Eza - ls replacement
			eza
			# TLDR
			tealdeer
			fastfetch
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
        settings = {
            user = {
                email = "olsonluke42@gmail.com";
                name = "Luke Olson";
            };
        };
        signing.format = null;
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
