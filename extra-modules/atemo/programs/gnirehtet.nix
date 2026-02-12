{ config, lib, pkgs, ... }: let cfg = config.programs.gnirehtet; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.gnirehtet.enable = lib.mkEnableOption ''
		Whether to enable gnirehtet, allowing reverse-tethering over ADB for Android.
	'';

	config = lib.mkIf cfg.enable {
		environment.systemPackages = with pkgs; [
			gnirehtet
			android-tools
		];

		users.users.${config.userName}.extraGroups = [ "adbusers" ];
	};
}