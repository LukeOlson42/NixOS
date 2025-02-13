
{ inputs, user, ... }:

{
    home = {
        username = "${user}";
        homeDirectory = "/home/${user}";
    };

    home.stateVersion = "24.11";
}
