{ config, pkgs, ... }:
let
    zshTheme = ''
        autoload -U colors && colors
        PROMPT='%B%{$fg[white]%}[%{$fg[green]%}%n%{$fg[white]%}@%{$fg[green]%}%M %{$fg[white]%}%~%{$fg[white]%}]%{$fg[white]%} $%b '
    '';
in
{
    home.file.".oh-my-zsh/custom/themes/lukeolson.zsh-theme".text = zshTheme;
    programs.zsh = {
        enable = true;
        enableCompletion = true;

        shellAliases = {
            mkos = "sudo nixos-rebuild switch --show-trace --upgrade --flake $NIX_FLAKE_PATH";
            mkhm = "home-manager switch --flake ${config.home.homeDirectory}/NixOS/#lukeolson@nixon --show-trace";
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
            plugins = [
                "sudo"
            ];
        };
    };

    programs.zoxide = {
        enable = true;
        enableZshIntegration = true;
        options = [
            "--cmd cd"
        ];
    };
}

# sudo nixos-rebuild switch --flake ${dir}/#mainDesktop --show-trace --impure --upgrade
# home-manager switch --flake ${dir}/#lukeolson@nixon --show-trace

