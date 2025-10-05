{ config, lib, pkgs, ... }: let cfg = config.programs.keymapp; in {
	options.programs.keymapp = {
		enable = lib.mkEnableOption "Application for ZSA keyboards";
		package = lib.mkPackageOption pkgs "keymapp" {};
	};

	config = lib.mkIf cfg.enable {
		environment.systemPackages = [ cfg.package ];
		hardware.keyboard.zsa.enable = true;
	};
}