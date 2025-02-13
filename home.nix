
{ inputs, user, programs, ... }:

{
    programs.home-manager.enable = true;

    home = {
        username = "${user}";
        homeDirectory = "/home/${user}";
    };

    home.stateVersion = "24.11";
}
