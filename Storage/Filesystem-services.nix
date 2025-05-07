{ config, ... }: { services = {

	# Whether to enable GVfs, a userspace virtual filesystem.
	gvfs.enable = true;

	# Whether to enable the smartd daemon from the smartmontools package.
	smartd.enable = true;

	# If XFCE's Thunar is enabled, enable the Tumbler D-Bus thumbnailer service.
	# Note that it is also installed as a standalone package for other needs.
	tumbler.enable = config.programs.thunar.enable;

	# Whether to enable the udiks2 DBus service that allows application to query and manipulate storage devices.
	udisks2.enable = true;

}; }
