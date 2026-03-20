{ ... }: { services = {
	libinput = {
		# Disable pointer acceleration for mices.
		mouse.accelProfile = "flat";

		touchpad = {
			# Disable pointer acceleration for touchpads.
			accelProfile = "flat";

			# Enable tap-to-click behavior.
			tapping = true;
		};
	};

	xserver = {
		# Delay in milliseconds before a held-down key repeats.
		autoRepeatDelay = 224;

		# Rate in characters per second to repeat when holding down a key.
		autoRepeatInterval = 25;
	};
}; }