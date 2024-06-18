{ config, pkgs, ... }: {

	home-manager.users.${config.Custom.Name}.wayland.windowManager.hyprland = {
		# Whether to enable the Hyprland Wayland compositor.
		# https://nix-community.github.io/home-manager/options.xhtml#opt-wayland.windowManager.hyprland.enable
		enable = true;

		# The Hyprland package to use.
		# https://nix-community.github.io/home-manager/options.xhtml#opt-wayland.windowManager.hyprland.package
		package = pkgs.unstable.hyprland;

		# Hyprland settings. Here, it sources a split configuraion in the user's directory.
		# https://nix-community.github.io/home-manager/options.xhtml#opt-wayland.windowManager.hyprland.settings
		settings.source = [
			"$HOME/.config/hypr/Hyprland/Animations.conf"
			"$HOME/.config/hypr/Hyprland/Autostart.conf"
			"$HOME/.config/hypr/Hyprland/Bindings.conf"
			"$HOME/.config/hypr/Hyprland/Decoration.conf"
			"$HOME/.config/hypr/Hyprland/Environment-variables.conf"
			"$HOME/.config/hypr/Hyprland/General.conf"
			"$HOME/.config/hypr/Hyprland/Global-shortcuts.conf"
			"$HOME/.config/hypr/Hyprland/Input.conf"
			"$HOME/.config/hypr/Hyprland/Layout.conf"
			"$HOME/.config/hypr/Hyprland/Miscellaneous.conf"
			"$HOME/.config/hypr/Hyprland/Monitor.conf"
			"$HOME/.config/hypr/Hyprland/Window-rules.conf"
		];
	};

	# Environment variable that tells programs such as Electron ones to use Wayland by default.
	# https://search.nixos.org/options?channel=24.05&show=environment.sessionVariables
	environment.sessionVariables.NIXOS_OZONE_WL = "1";

}
