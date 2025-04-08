{ config, pkgs, ... }: { systemd.services ={

	# Alternative suspend command.
	"systemd-suspend".serviceConfig.ExecStart = [
		""
		"${pkgs.pmutils}/bin/pm-suspend"
	];

	# Alternative hibernate command.
	"systemd-hibernate".serviceConfig.ExecStart = [
		""
		"${pkgs.pmutils}/bin/pm-hibernate"
	];

	# Alternative hybrid sleep command.
	"systemd-hybrid-sleep".serviceConfig.ExecStart = [
		""
		"${pkgs.pmutils}/bin/pm-hybrid-sleep"
	];

}; }
