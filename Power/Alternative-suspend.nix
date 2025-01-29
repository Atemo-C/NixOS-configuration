{ config, lib, pkgs, ... }: { systemd.services = {

	# Alternative suspend command.
	systemd-suspend.serviceConfig.ExecStart = lib.mkForce "${pkgs.pmutils}/bin/pm-suspend";

	# Alternative hibernate command.
	systemd-hibernate.serviceConfig.ExecStart = lib.mkForce "${pkgs.pmutils}/bin/pm-hibernate";

	# Alternative hybrid sleep command.
	systemd-hybrid-sleep.serviceConfig.ExecStart = lib.mkForce "${pkgs.pmutils}/bin/pm-hybrid-sleep";

}; }
