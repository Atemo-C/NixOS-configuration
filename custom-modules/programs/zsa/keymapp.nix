{ config, lib, pkgs, ... }: let cfg = config.programs.zsa.keymapp; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.zsa.keymapp = {
		enable = lib.mkEnableOption ''
			Whether to install Keymapp, a graphical program to interact with and flash firmware onto ZSA keyboards.
			If `true`, `hardware.keyboard.zsa` will be enabled.
		'';

		package = lib.mkPackageOption pkgs "keymapp" {};
	};

	config = lib.mkIf cfg.enable {
		environment.systemPackages = [ cfg.package ];
		hardware.keyboard.zsa.enable = true;
	};
}