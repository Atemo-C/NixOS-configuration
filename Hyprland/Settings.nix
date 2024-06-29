{ config, pkgs, ... }: {

	home-manager.users.${config.Custom.Name}.wayland.windowManager.hyprland = {
		# Whether to enable the Hyprland Wayland compositor.
		# https://nix-community.github.io/home-manager/options.xhtml#opt-wayland.windowManager.hyprland.enable
		enable = true;

		# The Hyprland package to use.
		# https://nix-community.github.io/home-manager/options.xhtml#opt-wayland.windowManager.hyprland.package
		package = pkgs.unstable.hyprland;
	};

	# Environment variable that tells programs such as Electron ones to use Wayland by default.
	# https://search.nixos.org/options?channel=24.05&show=environment.sessionVariables
	environment.sessionVariables.NIXOS_OZONE_WL = "1";

}
