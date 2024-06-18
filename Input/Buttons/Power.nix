{ config, ... }: {

	# Extra config options for systemd-logind. Here, used to ignore the press of the power button.
	# https://search.nixos.org/options?channel=24.05&show=services.logind.extraConfig
	services.logind.extraConfig = ''HandlePowerKey=ignore'';

}
