{ config, ... }: { services = {

	# Whether to enable GVfs, a userspace virtual filesystem.
	gvfs.enable = true;

	# Whether to enable smartd daemon from the smartmontools package.
	smartd.enable = true;

	# Whether to enable the Tumbler D-Bus thumbnailer service.
	tumbler.enable = true;

	# Whether to enable udiks2, a DBus service that allows application to query and manipulate storage devices.
	udisks2.enable = true;

}; }
