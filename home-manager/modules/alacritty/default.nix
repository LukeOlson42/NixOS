{ config, lib, pkgs, ... }:

let
    colorscheme = import ../../../colors.nix;
in
{
	programs.alacritty = {
		enable = true;
		settings = {
			font = {
				size = 10;
				normal.family = "JetBrains Mono";
				bold.family = "JetBrains Mono";
				italic.family = "JetBrains Mono";
			};

            colors = colorscheme.simple_green;

            mouse.bindings = [
                { "mouse" = "Right"; "action" = "Paste"; }
            ];

            cursor.style = "Block";

			shell.program = "zsh";
            window.opacity = 0.9;
		};
	};
}
