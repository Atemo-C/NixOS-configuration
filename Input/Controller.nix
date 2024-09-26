# Used NixOS packages:
#─────────────────────
# [jstest-gtk]
# https://jstest-gtk.gitlab.io/

# A simple joystic tester based on Gtk+.
{ pkgs, ... }: { environment.systemPackages = [ pkgs.jstest-gtk ]; }
