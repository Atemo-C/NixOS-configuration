{ config, lib, pkgs, ... }: { systemd.services = {

	# Alternative suspend command.
	sleep.serviceConfig.ExecStart = lib.mkForce "${pkgs.pm-suspend}/bin/pm-suspend";

	# Alternative hibernate command.
	hibernate.serviceConfig.ExecStart = lib.mkForce "${pkgs.pm-suspend}/bin/pm-hibernate";

	# Alternative hybrid sleep command.
	hybrid-sleep.serviceConfig.ExecStart = lib.mkForce "${pkgs.pm-suspend}/bin/pm-suspend-hybrid";

}; }
