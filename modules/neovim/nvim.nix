{ config, lib, pkgs, ... }:

{
	# Packages that Neovim needs
	home.packages = with pkgs; [
		ripgrep
		fd
	];

	# I use neovim on multiple platforms, so this
	# lets me use the same Lua config :3
	xdg.configFile = {
		"nvim/lua".source = ./nvim-config/lua;
		"nvim/init.lua".source = ./nvim-config/init.lua;
	};

	programs.neovim = {
		enable = true;
		viAlias = true;
		vimAlias = true;
		vimdiffAlias = true;
		defaultEditor = true;
	};
}
