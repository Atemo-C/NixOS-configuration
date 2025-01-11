{ config, pkgs, ... }: {

	environment.systemPackages = [
		# A monitor of resources.
		pkgs.btop

		# Free software that gathers information on CPU, motherboard and more.
		pkgs.cpu-x

		# Tools for reading hardware sensors.
		pkgs.lm_sensors

		# Tools for monitoring the health of hard drives.
		pkgs.smartmontools

		# Mersenne prime search / System stability tester (torture).
		pkgs.mprime

		# Vulkan tools and utilties.
		pkgs.vulkan-tools

		# Collection of demos and test programs for OpenGL and Mesa.
		pkgs.mesa-demos

		# Provide detailed information on the hardware configuration of the machine.
		pkgs.lshw
	];

	# Fastfetch, like Neofetch, but in C, much faster, and actually maintained.
	home-manager.users.${config.custom.name}.programs.fastfetch = {
		# Whether to enable fastfetch.
		enable = true;

		# Configuration written to $XDG_CONFIG_HOME/fastfetch/config.jsonc.
		settings = {
			"$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
			logo = "none";
			modules = [
				"break"
				{
					type = "custom";
					key = "  Central processing unit";
					keyColor = "Cyan";
				}
				{
					type = "cpu";
					key = "Model";
					keyColor = "Magenta";
					format = "{1}";
				}
				{
					type = "cpu";
					key = "Cores";
					format = "{3} cores and {4} threads at {7}Ghz";
				}
				"break"
				{
					type = "custom";
					key = "  Graphics processing unit";
				}
				{
					type = "gpu";
					key = "Model";
					keyColor = "Magenta";
					format = "  {1} {2}";
				}
				{
					type = "gpu";
					key = "Drivers";
					format = "{3}";
				}
				"break"
				{
					type = "custom";
					key = "  Random access memory";
				}
				{
					type = "memory";
					key = "Total physical memory";
					keyColor = "Magenta";
					format = "{2}";
				}
				{
					type = "memory";
					key = "Used physical memory";
					format = " {1} ({3})";
				}
				"break"
				{
					type = "custom";
					key = "  Virtual \"swap\" memory";
				}
				{
					type = "swap";
					key = "Total swap";
					keyColor = "Magenta";
					format = "{2}";
				}
				{
					type = "swap";
					key = "Used swap";
					format = " {1} ({3})";
				}
				"break"
				{
					type = "custom";
					key = "  Attached storage";
				}
				{
					type = "disk";
					key = "Storage";
					keyColor = "Magenta";
					format = "[{10}] = {1} / {2} [{3}]";
				}
				"break"
				{
					type = "custom";
					key = "  Attached displays";
				}
				{
					type = "display";
					key = "Dipslay";
					keyColor = "Magenta";
					format = "[{6}] = 󰨤  {1}×{2}@{3}Hz, 󰲏  {4}×{5} 󰑵  {8}°";
				}
				"break"
				{
					type = "custom";
					key = "  Attached batteries";
				}
				{
					type = "battery";
					key = "Battery";
					keyColor = "Magenta";
					format = "{1} {2} ({3}), {4} {5} {6} {7}";
				}
				"break"
				"break"
				{
					type = "custom";
					key = "  User & host";
				}
				{
					type = "title";
					key = "  Username";
					keyColor = "Magenta";
					format = "  {1}";
				}
				{
					type = "shell";
					key = "  User shell";
					keyColor = "Magenta";
					format = "{6}";
				}
				{
					type = "title";
					key = "  Host name";
					keyColor = "Magenta";
					format = " {2}";
				}
				{
					type = "localip";
					key = "  Local IPv4";
					keyColor = "Magenta";
					format = "{1} ({4})";
				}
				"break"
				{
					type = "custom";
					key = "  System";
				}
				{
					type = "os";
					key = "  Operating system";
					keyColor = "Magenta";
					format = "{3}";
				}
				{
					type = "kernel";
					key = "  Linux kernel";
					keyColor = "Magenta";
					format = "    {1} {2}";
				}
				{
					type = "uptime";
					key = "  System uptime";
					keyColor = "Magenta";
					format = "   {1}d {2}h {3}m {4}s";
				}
				"break"
				{
					type = "custom";
					key = "  Environment";
				}
				{
					type = "wm";
					key = "  Wayland compositor";
					keyColor = "Magenta";
					format = "{2}";
				}
				{
					type = "terminal";
					key = "  Terminal emulator";
					keyColor = "Magenta";
					format = " {1}";
				}
				{
					type = "terminalfont";
					key = "  Terminal font";
					keyColor = "Magenta";
					format = "     {1}";
				}
				"break"
				{
					type = "custom";
					key = "  Theming";
				}
				{
					type = "font";
					key = "  Program font";
					keyColor = "Magenta";
					format = " {2}";
				}
				{
					type = "theme";
					key = "  Program theme";
					keyColor = "Magenta";
					format = "{1}";
				}
				{
					type = "icons";
					key = "  Icons theme";
					keyColor = "Magenta";
					format = "  {1}";
				}
				{
					type = "cursor";
					key = "  Cursor theme";
					keyColor = "Magenta";
					format = " {1}";
				}
				"break"
			];
		};
	};

}
