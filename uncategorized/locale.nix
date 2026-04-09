{ ... }: {
	i18n = {
		defaultLocale = "en_GB.UTF-8";

		extraLocaleSettings = rec {
			LC_ADDRESS = "fr_FR.UTF-8";
			LC_IDENTIFICATION = LC_ADDRESS;
			LC_MEASUREMENT = LC_ADDRESS;
			LC_MONETARY = LC_ADDRESS;
			LC_NAME = LC_ADDRESS;
			LC_NUMERIC = LC_ADDRESS;
			LC_PAPER = LC_ADDRESS;
			LC_TELEPHONE = LC_ADDRESS;
			LC_TIME = "en_GB.UTF-8";
		};
	};

	time = {
		timeZone = "Europe/Paris";
		hardwareClockInLocalTime = true;
	};
}