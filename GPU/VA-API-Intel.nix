# Enabling VA-API for compatible Intel GPUs.
{ config, pkgs, ... }: { hardware.graphics.extraPackages = [

	# For modern Intel GPUs:
	pkgs.intel-media-driver

	# For older Intel GPUs using the i965 driver:
#	pkgs.intel-vaapi-driver

]; }
