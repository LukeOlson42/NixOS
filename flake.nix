{
    description = "Luke's NixOS Flake!";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
        sddm-sugar-candy-nix = {
            url = "github:Zhaith-Izaliel/sddm-sugar-candy-nix";
            inputs.nixpkgs.follows = "nixpkgs";
        };
	};

	outputs = { self, nixpkgs, home-manager, ... }@inputs:
	let
        inherit (self) outputs;

        commonInherits = {
            inherit (nixpkgs) lib;
            inherit inputs outputs nixpkgs home-manager;
        };

        user = "lukeolson";

        systems = {
            # Add more systems here, e.g. asus-laptop
            main-desktop = {
                modules = [
                    /docker
                    /minecraft
                    /gaming
                    /nemo
                ];

                hm-modules = [
                    /alacritty
                    /hyprland
                    /neovim
                    /sioyek
                    /yazi
                    /zsh
                ];
            };
        };

        mkSystem = host: system:
            import ./hosts.nix
                (commonInherits // {
                    hostName = "${host}";
                    user = system.user or user;
                } // system);
	in
	{
        nixosConfigurations = nixpkgs.lib.mapAttrs mkSystem systems;
	};
}
