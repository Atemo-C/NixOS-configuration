# Enabling VA-API for compatible Intel GPUs.
{ config, pkgs, ... }: { hardware.graphics.extraPackages = [

	# For modern Intel GPUs:
	intel-media-driver

	# For older Intel GPUs using the i965 driver:
#	intel-vaapi-driver

]; }
