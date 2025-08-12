# Whether to enable the Waydroid Android emulator.
{ config, lib, ... }: lib.mkIf config.programs.niri.enable { virtualisation.waydroid.enable = true; }