{
    inputs,
    nixpkgs,
    home-manager,
    hostName,
    user,
    modules? [],
    hm-modules ? [],
    extraImports ? [],
    ...
}:
let 
    commonNixOSModules = hostName: [
        {
            networking.hostName = hostName;
            nix.settings.experimental-features = ["nix-command" "flakes"];
        }

        ./machines/${hostName}
        ./base.nix
        ./nixos/common
    ];

    mkNixOSModules = modules: (map (n: ./nixos/modules/${n}) modules);
    mkHmManagerModules = modules: (map (n: ./home-manager/modules/${n}) modules);

    mkHost = hostName: user: modules: hmModules: extraImports:
        nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = commonNixOSModules hostName
                ++ mkNixOSModules modules
                ++ [
                    home-manager.nixosModules.home-manager {
                        home-manager.extraSpecialArgs = {
                            inherit inputs;
                            inherit (inputs) hyprland;
                            inherit user;
                        };
                        home-manager.useUserPackages = true;
                        home-manager.users.${user}.imports = [
                            ./home.nix
                            ./home-manager/common
                        ]
                        ++ mkHmManagerModules hm-modules;
                    }
                ]
                ++ extraImports;

            specialArgs = {
                inherit inputs;
                inherit user;
            };
        };
in
    mkHost hostName user modules hm-modules extraImports
