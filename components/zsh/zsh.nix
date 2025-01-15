{ config, lib, pkgs, ... }:

let
    zshTheme = ''
        autoload -U colors && colors
        PROMPT='%B%{$fg[white]%}[%{$fg[green]%}%n%{$fg[white]%}@%{$fg[green]%}%M %{$fg[green]%}%~%{$fg[white]%}]%{$fg[white]%} $%b '
    '';
in
{
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

    programs.zoxide = {
        enable = true;
        enableZshIntegration = true;
        options = [
            "--cmd cd"
        ];
    };
}
