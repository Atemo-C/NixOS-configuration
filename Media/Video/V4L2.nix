{ config, pkgs, ... }: {

	boot = {
		# V4L2 kernel module.
		# https://search.nixos.org/options?channel=24.05&show=boot.extraModulePackages
		# https://search.nixos.org/options?channel=24.05&show=boot.initrd.kernelModules
		extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
		initrd.kernelModules = [ "v4l2loopback" ];
	};

	# Video4Linux2 utilties.
	environment.systemPackages = with pkgs; [ v4l-utils ];

}
