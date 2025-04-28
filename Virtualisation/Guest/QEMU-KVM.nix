{ config, ... }: { services = {

	# Enable the Spice guest vdagent daemon.
	spice-vdagentd.enable = true;

	# Enable the qemu guest agent.
	qemuGuest.enable = true;

}; }
