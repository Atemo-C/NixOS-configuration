{ config, lib, pkgs, ... }: let cfg = config.programs.wally-cli; in {
	options.programs.wally-cli = {
		enable = lib.mkEnableOption "Tool to flash firmware to mechanical keyboards";
		package = lib.mkPackageOption pkgs "wally-cli" {};
	};

	config = lib.mkIf cfg.enable {
		environment.systemPackages = [ cfg.package ];
		hardware.keyboard.zsa.enable = true;
	};
}