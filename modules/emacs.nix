{ config, lib, pkgs, ... }:

{
    programs.emacs = {
        enable = true;
        package = pkgs.emacs29-pgtk;
        extraConfig = ''
            (tool-bar-mode 0)
            (menu-bar-mode 0)
            (scroll-bar-mode 0)
            (column-number-mode 1)
            (show-paren-mode 1)
            (global-display-line-numbers-mode)

            (setq-default inhibit-splash-screen t
                          make-backup-files nil
                          tab-width 4
                          indent-tabs-mode nil)

            (require 'package)
            (add-to-list 'package-archives
                '("melpa" . "http://melpa.milkbox.net/packages/") t)
            (load-theme 'gruber-darker)
        '';
    };
}
