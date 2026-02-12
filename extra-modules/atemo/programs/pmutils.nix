{ config, lib, pkgs, ... }: let cfg = config.programs.pmutils; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.pmutils = {
		enable = lib.mkEnableOption ''
			Whether to enable pmutils, a small collection of scripts that handle suspend and resume on behalf of HAL.
			They can be useful on hardware where default suspend/resume actions do not work due to various reasons, such as firmware bugs on older laptops.
		'';

		replaceSuspend = lib.mkEnableOption ''
			Whether `pm-suspend` should be used when invoking system suspend, e.g. via `systemctl suspend`.
		'';

		replaceHibernate = lib.mkEnableOption ''
			Whether `pm-hibernate` should be used when invoking system hibernation, e.g. via `systemctl hibrenate`.
		'';

		replaceHybridSleep = lib.mkEnableOption ''
			Whether `pm-suspend-hybrid` should be used when invoking system suspend, e.g. via `systectl hybrid-sleep`.
		'';

		replaceAll = lib.mkEnableOption ''
			Whether `pm-suspend`, `pm-hibernate`, and `pm-suspend-hybrid` should be used when invoking their respective action, e.g. the various `systemctl` commands.
			Enabling this option avoids having to enable all three others separately.
		'';
	};

	config = lib.mkIf cfg.enable {
		environment.systemPackages = cfg.package;

		systemd.services = {
			systemd-suspend = lib.mkIf (cfg.replaceSuspend || cfg.replaceAll) {
				description = "System suspend with pm-suspend";
				serviceConfig = {
					Type = "oneshot";
					Environment = "PATH=${pkgs.pmutils}/bin";
					ExecStart = [ "" "${pkgs.pmutils}/bin/pm-suspend" ];
				};
			};

			systemd-hibernate = lib.mkIf (cfg.replaceHibernate || cfg.replaceAll) {
				description = "System hibernation with pm-hibernate";
				serviceConfig = {
					Type = "oneshot";
					Environment = "PATH=${pkgs.pmutils}/bin";
					ExecStart = [ "" "${pkgs.pmutils}/bin/pm-hibernate" ];
				};
			};

			systemd-hybrid-sleep = lib.mkIf (cfg.replaceHybridSleep || cfg.replaceAll) {
				description = "System hybrid suspend with pm-suspend-hybrid";
				serviceConfig = {
					Type = "oneshot";
					Environment = "PATH=${pkgs.pmutils}/bin";
					ExecStart = [ "" "${pkgs.pmutils}/bin/pm-suspend-hybrid" ];
				};
			};
		};
	};
}