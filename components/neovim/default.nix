{ config, lib, pkgs, ... }:

{
	# Packages that Neovim needs
	home.packages = with pkgs; [
		ripgrep
		fd
        lua-language-server
	];

	# I use neovim on multiple platforms, so this
	# lets me use the same Lua config :3
	xdg.configFile = {
		"nvim/lua".source =  /. + "/home/lukeolson/config.nvim/lua";
		"nvim/init.lua".source = /. + "/home/lukeolson/config.nvim/init.lua";
	};

	programs.neovim = {
		enable = true;
		viAlias = true;
		vimAlias = true;
		vimdiffAlias = true;
		defaultEditor = true;
	};
}
