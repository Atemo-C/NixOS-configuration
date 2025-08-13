# Eww widget system; Currently only here for the crosshair.
{ config, pkgs, ... }: { environment.systemPackages = [ pkgs.eww ]; }