{ pkgs, ... }: {

	environment.systemPackages = with pkgs; [
		# TUI resource usage monitoring.
		btop
		htop

		# GUI resource usage monitoring.
		unstable.mission-center

		# CPU information.
		cpu-x

		# Hardware sensors data.
		lm_sensors

		# Disk monitoring tools.
		smartmontools
	];

}
