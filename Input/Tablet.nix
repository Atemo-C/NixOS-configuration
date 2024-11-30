# Documentation:
#───────────────
# • https://opentabletdriver.net/Wiki
# • https://wiki.nixos.org/wiki/OpenTabletDriver
# • https://wiki.hyprland.org/FAQ/#how-do-i-autostart-my-favorite-apps
#
# Used NixOS options:
#────────────────────
# • https://search.nixos.org/options?channel=24.11&show=hardware.opentabletdriver.daemon.enable = true;
# • https://search.nixos.org/options?channel=24.11&show=hardware.opentabletdriver.enable = true;
#
# Used Home Manager options:
#───────────────────────────
# • https://nix-community.github.io/home-manager/options.xhtml#opt-wayland.windowManager.hyprland.settings

{ config, ... }: {

	# Use OpenTabletDriver instead of the standard graphical tablet drivers, such as the ones provided by Wacom.
	hardware.opentabletdriver = {
		# Whether to start OpenTabletDriver daemon as a systemd user service.
		daemon.enable = true;

		# Enable OpenTabletDriver udev rules, user service and blacklist kernel modules that conflict with it.
		enable = true;
	};

	# Starts the OpenTabletDriver dameon when the Hyprland Wayland compositor is started.
	home-manager.users.${config.custom.name}.wayland.windowManager.hyprland.settings.exec-once = [ "otd-dameon" ];

}
