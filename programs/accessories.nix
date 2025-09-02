{ config, lib, pkgs, ... }: lib.mkIf config.programs.niri.enable { environment.systemPackages = with pkgs; [
	minder    # Mind-mapping utility.
	keepassxc # Offline password manager.
]; }