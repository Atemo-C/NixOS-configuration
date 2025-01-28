{ config, lib, pkgs, ... }: { systemd.services = {

	# Alternative suspend command.
	sleep.serviceConfig.ExecStart = lib.mkForce "${pkgs.pmutils}/bin/pm-suspend";

	# Alternative hibernate command.
	hibernate.serviceConfig.ExecStart = lib.mkForce "${pkgs.pmutils}/bin/pm-hibernate";

	# Alternative hybrid sleep command.
	hybrid-sleep.serviceConfig.ExecStart = lib.mkForce "${pkgs.pmutils}/bin/pm-suspend-hybrid";

}; }
