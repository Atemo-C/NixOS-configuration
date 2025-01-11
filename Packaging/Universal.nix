{ config, pkgs, ... }: {

	# AppImages.
	programs.appimage = {
		# Whether to enable binfmt registration to run appimages via appimage-run seamlessly.
		binfmt = true;

		# Whether to enable the appimage-run wrapper script for executing AppImages on NixOS.
		enable = true;
	};

	# Whether to enable the Flatpak packaging system.
	services.flatpak.enable = true;

}
