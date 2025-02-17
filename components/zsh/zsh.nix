{ config, lib, pkgs, ... }:

let
    zshTheme = ''
        autoload -U colors && colors
        PROMPT='%B%{$fg[white]%}[%{$fg[green]%}%n%{$fg[white]%}@%{$fg[green]%}%M %{$fg[white]%}%~%{$fg[white]%}]%{$fg[white]%} $%b '
    '';

    hmDir = config.home.homeDirectory;
in
{
    home.file.".oh-my-zsh/custom/themes/lukeolson.zsh-theme".text = zshTheme;

	programs.zsh = {
		enable = true;
		enableCompletion = true;
		shellAliases = {
			ls = "eza -l -s extension";
			cls = "clear";
            mkos = "sudo nixos-rebuild switch --flake ${hmDir}/NixOS/#main-desktop --show-trace --impure";
		};

        dotDir = ".config/zsh";

		history = {
			size = 1000;
			path = "${config.xdg.dataHome}/zsh/history";
		};

        oh-my-zsh = {
            enable = true;
            theme = "lukeolson";
            custom = "${hmDir}/.oh-my-zsh/custom";
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
