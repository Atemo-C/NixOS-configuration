{ config, pkgs, ... }: {

	# CUPS drivers to use.
	# https://search.nixos.org/options?channel=24.05&show=services.printing.drivers
	services.printing.drivers = with pkgs; [ hplip ];

	hardware.sane = {
		# Extra SANE backends to enable.
		# https://search.nixos.org/options?channel=24.05&show=hardware.sane.extraBackends
		extraBackends = with pkgs; [ hplipWithPlugin ];

		# SANE backends to disable that are enabled by default.
		# https://search.nixos.org/options?channel=24.05&show=hardware.sane.disabledDefaultBackends
		disabledDefaultBackends = [ "escl" ];
	};

}
