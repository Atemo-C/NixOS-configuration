# Documentation:
#───────────────
# • https://wiki.hyprland.org/Nix/
# • https://wiki.nixos.org/wiki/Hyprland
#
# Used NixOS options:
#────────────────────
# • https://search.nixos.org/options?channel=24.05&show=environment.sessionVariables
# • https://search.nixos.org/options?channel=24.05&show=programs.hyprland.enable
# • https://search.nixos.org/options?channel=24.05&show=programs.hyprland.package
# • https://search.nixos.org/options?channel=24.05&show=nixpkgs.overlays
#
# Used Home Manager options:
#───────────────────────────
# • https://nix-community.github.io/home-manager/options.xhtml#opt-wayland.windowManager.hyprland.enable
# • https://nix-community.github.io/home-manager/options.xhtml#opt-wayland.windowManager.hyprland.package

{ config, pkgs, ... }: {

	# Environment variable that tells programs such as Electron ones to use Wayland by default when possible.
	environment.sessionVariables.NIXOS_OZONE_WL = "1";

	home-manager.users.${config.custom.name}.wayland.windowManager.hyprland = {
		# Whether to enable the Hyprland Wayland compositor for the user.
		enable = true;

		# The Hyprland package to use.
		package = pkgs.unstable.hyprland;
	};

	programs.hyprland = {
		# Whether to enable Hyprland, the dynamic tiling Wayland compositor that doesn’t sacrifice on its looks.
		# Needed even with the Home Manager module for an optimal experience.
		enable = true;

		# # The hyprland package to use.
		package = pkgs.unstable.hyprland;
	};

	# Hyprland override for enabling the legacy renderer.
#	nixpkgs.overlays = with pkgs.unstable; [(self: super: { hyprland = super.hyprland.override {
#		legacyRenderer = true;
#	}; }) ];

}
