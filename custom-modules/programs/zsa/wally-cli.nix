{ config, lib, pkgs, ... }: let cfg = config.programs.zsa.wally-cli; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.zsa.wally-cli = {
		enable = lib.mkEnableOption ''
			Whether to install wally-cli, a CLI program to flash firmware onto ZSA keyboards.
			If `true`, `hardware.keyboard.zsa` will be enabled.
		'';

		package = lib.mkPackageOption pkgs "wally-cli" {};
	};

	config = lib.mkIf cfg.enable {
		environment.systemPackages = [ cfg.package ];
		hardware.keyboard.zsa.enable = true;
	};
}