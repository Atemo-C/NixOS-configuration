{ config, pkgs, ... }: {

	# Make use of the hplip CUPS drivers.
	services.printing.drivers = [ pkgs.hplipWithPlugin ];

	hardware.sane = {
		# Enable the hplip SANE backend.
		extraBackends = [ pkgs.hplipWithPlugin ];

		# SANE backends to disable that can conflict with the desired HP backends.
		disabledDefaultBackends = [ "escl" ];
	};

}
