{ config, pkgs, ... }: {

	environment.systemPackages = with pkgs; [
		# Show mouse refresh rate under linux + evdev
		evhz
	];

}
