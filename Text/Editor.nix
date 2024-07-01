{ config, pkgs, ... }: {

	environment = {
		# Micro text editor.
		systemPackages = with pkgs; [ micro ];

		# Set Micro as the default text editor.
		variables = { EDITOR = "micro"; };
	};

	# Disabling the nano text editor enabled by default.
	# https://search.nixos.org/options?channel=24.05&show=programs.nano.enable
	programs.nano.enable = false;

}
