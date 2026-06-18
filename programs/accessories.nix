{ pkgs, ... }: { environment.systemPackages = with pkgs; [
	# Offline password manager.
	keepassxc

	# Tool to write image files to portable media.
	# (e.g. ISO -> Bootable USB flash drive)
	mediawriter

	# Remote desktop client written in GTK.
	remmina

	# Tool to write Windows ISO files to USB flash drives.
	woeusb
]; }