{ config, lib, pkgs, ... }:

let
    colorscheme = import ../colors.nix;
in
{
	programs.alacritty = {
		enable = true;
		settings = {
			font = {
				size = 10;
				normal.family = "JetBrains Mono Nerd Font";
				bold.family = "JetBrains Mono Nerd Font";
				italic.family = "JetBrains Mono Nerd Font";
			};

            colors = colorscheme.simple_green;

            mouse.bindings = [
                { "mouse" = "Right"; "action" = "Paste"; }
            ];

            cursor.style = "Block";

			terminal.shell.program = "zsh";
            window.opacity = 0.9;
		};
	};
}
