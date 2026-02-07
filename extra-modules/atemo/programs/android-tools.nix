{ config, lib, pkgs, ... }: let cfg = config.programs.android-tools; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.android-tools.enable = lib.mkEnableOption ''
		Whether to enable android-tools, the Android SDK platform tools.
	'';

	config = lib.mkIf cfg.enable {
		environment.systemPackages = [ pkgs.android-tools ];

		users.users.${config.userName}.extraGroups = [ "adbusers" ];
	};
}