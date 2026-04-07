{ config, ... }: {
	console.useXkbConfig = true;

	environment.variables = {
		XKB_DEFAULT_LAYOUT = config.services.xserver.xkb.layout;
		XKB_DEFAULT_MODEL = config.services.xserver.xkb.model;
		XKB_DEFAULT_OPTIONS = config.services.xserver.xkb.options;
		XKB_DEFAULT_VARIANT = config.services.xserver.xkb.variant;
	};

	services = {
		kmscon.useXkbConfig = true;

		libinput = {
			mouse.accelProfile = "flat";
			touchpad.tapping = true;
		};

		xserver = {
			autoRepeatDelay = 224;
			autoRepeatInterval = 25;
		};
	};
}