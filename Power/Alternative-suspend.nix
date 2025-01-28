{ config, ... }: { systemd.services = {

	# Alternative suspend command.
	sleep.serviceConfig.ExecStart = lib.mkForce "/run/current-system/sw/bin/pm-suspend";

	# Alternative hibernate command.
	hibernate.serviceConfig.ExecStart = lib.mkForce "/run/current-system/sw/bin/pm-hibernate";

	# Alternative hybrid sleep command.
	hybrid-sleep.serviceConfig.ExecStart = lib.mkForce "/run/current-system/sw/bin/pm-suspend-hybrid";

}; }
