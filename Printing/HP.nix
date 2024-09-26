# Documentation:
#───────────────
# • https://wiki.nixos.org/wiki/Printing
#
# Used NixOS options:
#────────────────────
# • https://search.nixos.org/options?channel=24.05&show=services.printing.drivers
# • https://search.nixos.org/options?channel=24.05&show=hardware.sane.extraBackends
# • https://search.nixos.org/options?channel=24.05&show=hardware.sane.disabledDefaultBackends

{ config, pkgs, ... }: {

	# Make use of the hplip CUPS drivers.
	services.printing.drivers = [ pkgs.hplipWithPlugin ];

	hardware.sane = {
		# Enable the hplip SANE backend.
		extraBackends = [ pkgs.hplipWithPlugin ];

		# SANE backends to disable that can conflict with the desired backends.
		disabledDefaultBackends = [ "escl" ];
	};

}
