{ pkgs, ... }: {

	environment.systemPackages = with pkgs; [
		# Filesystem utilities.
		dosfstools
		sysfsutils

		# CLI search tool.
		fd

		# CLI list tool.
		lsd

		# CLI trash management.
		trashy

		# TUI disk usage analyzer.
		ncdu

		# Other utilities.
		shared-mime-info
		desktop-file-utils
	];

}

# To make .local/shre/applications/*.desktop files work properly, run these commands:
#	mkdir -p .local/share/applications
#	desktop-file-utils --run "update-desktop-database -v ~/.local/share/applications"
