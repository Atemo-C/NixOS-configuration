{ config, ... }: { services = {

	# Whether to enable the Spice guest vdagent daemon.
	spice-vdagentd.enable = true;

	# Whether to enable the qemu guest agent.
	qemuGuest.enable = true;

}; }
