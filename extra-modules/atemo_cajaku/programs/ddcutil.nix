{ config, lib, pkgs, ... }: let cfg = config.programs.ddcutil; in {
	options.programs.ddcutil.enable = lib.mkEnableOption "ddcutil, a tool to query and change Linux monitor settings using DDC/CI and USB.";

	config = lib.mkIf cfg.enable {
		environment.systemPackages = with pkgs; [ ddcutil ];

		services.ddccontrol.enable = true;

		users.users.${config.user.name}.extraGroups = "i2c";
}