{ config, lib, pkgs, ... }: let cfg = config.programs.pmutils; in {
	options.programs.pmutils = {
		enable = lib.mkEnableOption "pmutils, a small collection of scripts that handle suspend and resume on behalf of HAL. They can be useful on hardware where the default suspend and resume actions do not work, such as on certain old laptops with firmware bugs.";

		replace = {
			suspend = lib.mkEnableOption "pm-suspend as a replacement to systemctl suspend.";
			hibernate = lib.mkEnableOption "pm-hibernate as a replacement to systemctl hibernate.";
			hybridSleep = lib.mkEnableOption "pm-suspend-hybrid as a replacement to systemctl hybrid-sleep";
			all = lib.mkEnableOption "pm-suspend, pm-hibernate, and pm-suspend-hybrid as replacements to their systemctl equivalents.";
		};
	};

	config = lib.mkIf cfg.enable {
		environment.systemPackages = [ pkgs.pmutils ];

		systemd.services = {
			systemd-suspend = lib.mkIf (cfg.replace.suspend || cfg.replace.all) {
				description = "System suspend with pm-suspend";
				serviceConfig = {
					Type = "oneshot";
					Environment = "PATH=${pkgs.pmutils}/bin";
					ExecStart = [ "" "${pkgs.pmutils}/bin/pm-suspend" ];
				};
			};
		};

		systemd-hibernate = lib.mkIf (cfg.replace.hibernate || cfg.replace.all) {
			description = "System hibernation with pm-hibernate";
			serviceConfig = {
				Type = "oneshot";
				Environment = "PATH=${pkgs.pmutils}/bin";
				ExecStart = [ "" "${pkgs.pmutils}/bin/pm-hibernate" ];
			};
		};

		systemd-hybrid-sleep = lib.mkIf (cfg.replace.hybridSleep || cfg.replace.all) {
			description = "System hybrid suspend with pm-suspend-hybrid";
			serviceConfig = {
				Type = "oneshot";
				Environment = "PATH=${pkgs.pmutils}/bin";
				ExecStart = [ "" "${pkgs.pmutils}/bin/pm-suspend-hybrid" ];
			};
		};
	};
}