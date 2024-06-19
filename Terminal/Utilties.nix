{ config, pkgs, ... }: {

	environment.systemPackages = with pkgs; [
		# cat clone with syntax highlighting and Git integration.
		bat

		# TUI calendar.
		calcurse

		# Hides current window when launching an external program.
		devour

		# Dash shell. Speed.
		dash

		# Tool for retrieveing files over the network.
		wget

		# Git utilities.
		git
		gh

		# Man pages made easier.
		tldr

		# GNU's shell Parallel tool to execute jobs in parallel.
		parallel
	];

}
