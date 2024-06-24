{ config, pkgs, ... }: {

	qt = {
		# Selects the style to use for Qt applications.
		# https://search.nixos.org/options?channel=24.05&show=qt.style
		style = "breeze";

		# Selects the platform theme to use for Qt applications.
		# https://search.nixos.org/options?channel=24.05&show=qt.platformTheme
		platformTheme = "kde";
	};

	# Packages to help with integration.
	environment.systemPackages = with pkgs.kdePackages; [
		# Breeze theme.
		breeze

		# Integration (colorscheme, etc).
		plasma-integration
	];

}
