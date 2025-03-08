# Windows compatibility using the Bottles program.
# If there are errors, report them to nixpkgs first.
# Using the Flatpak version of Bottles might provide a better experience.
{ config, pkgs, ... }: { environment.systemPackages = [ (pkgs.bottles.override { removeWarningPopup = true; }) ]; }
