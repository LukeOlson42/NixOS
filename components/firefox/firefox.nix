{ pkgs, inputs, username, ... }:
let
    colorscheme = import ../colors.nix;
in
{
    imports = [
        inputs.textfox.homeManagerModules.default
    ];

    programs.firefox = {
        enable = true;
        profiles."${username}" = {
            search = {
                force = true;
                engines = {
                    "Nix Packages" = {
                        urls = [
                        {
                            template = "https://search.nixos.org/packages?channel=unstable";
                            params = [
                            {
                                name = "type";
                                value = "packages";
                            }
                            {
                                name = "query";
                                value = "{searchTerms}";
                            }
                            ];
                        }
                        ];
                        icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                        definedAliases = ["@np"];
                    };
                    "Nix Options" = {
                        urls = [
                        {
                            template = "https://search.nixos.org/options?channel=unstable";
                            params = [
                            {
                                name = "sort";
                                value = "alpha_asc";
                            }
                            {
                                name = "query";
                                value = "{searchTerms}";
                            }
                            ];
                        }
                        ];
                        icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                        definedAliases = ["@no"];
                    };
                    "NixOS Wiki" = {
                        urls = [
                        {
                            template = "https://wiki.nixos.org/w/index.php?search={searchTerms}";
                        }
                        ];
                        iconUpdateURL = "https://nixos.wiki/favicon.png";
                        updateInterval = 24 * 60 * 60 * 1000;
                        definedAliases = ["@nw"];
                    };
                    "Home Manager Options" = {
                        urls = [{template = "https://home-manager-options.extranix.com/?query={searchTerms}&release=master";}];
                        icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                        definedAliases = ["@hm"];
                    };
                };
            };
        };
    };

    textfox = {
        enable = true;
        profile = "${username}";
        config = {
            background = {
                color = colorscheme.simple_green.primary.background;
            };
            border = {
                color = colorscheme.simple_green.normal.green;
                width = "2px";
                radius = "2px";
            };
            font = {
                size = "12px";
            };
            tabs.vertical = {
                margin = "0.8rem";
            };
            displayNavButtons = true;
            displayTitles = false;
        };
    };
}
