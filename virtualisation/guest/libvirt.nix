{ config, lib, pkgs, ... }: {
	services = {
		# Whether to enable the spice-vdagentd daemon.
		spice-vdagentd.enable = true;

		# Whether to enable QEMU guest additions.
		qemuGuest.enable = true;
	};

	systemd.user.services.spice-vdagent = lib.mkIf config.services.spice-vdagentd.enable {
		description = "spice-vdagent user daemon";
		after = [ "spice-vdagentd.service" "graphical-session.target" ];
		requires = [ "graphical-session.target" ];
		wantedBy = [ "graphical-session.target" ];
		serviceConfig.ExecStart = "${pkgs.lib.getBin pkgs.spice-vdagent}/bin/spice-vdagent -x";
		unitConfig.ConditionPathExists = "/run/spice-vdagentd/spice-vdagent-sock";
	};
}