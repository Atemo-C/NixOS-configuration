# This module configures input settings for various input devices, notably keyboard and mice.
{ ... }: { services = {
	libinput = {
		# Set the mouse pointer acceleration profile to the given one.
		# adaptive | flat | custom
		mouse.accelProfile = "flat";

		# Set the touchpad pointer acceleration profile to the given one.
		# adaptive | flat | custom
		touchpad.accelProfile = "flat";
	};

	# Delay in milliseconds before a held-down key repeats;
	# Rate in characters per second to repeat when holding down a key.
	xserver = {
		# Delay in milliseconds before a held-down key repeats.
		autoRepeatDelay = 224;

		# Rate in characters per second to repeat when holding down a key.
		autoRepeatInterval = 25;
	};
}; }