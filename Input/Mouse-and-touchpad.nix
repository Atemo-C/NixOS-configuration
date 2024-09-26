# Documentation:
#───────────────
# • https://wiki.hyprland.org/Configuring/Variables/#input
# • https://wiki.hyprland.org/Configuring/Variables/#touchpad
#
# Used NixOS packages:
#─────────────────────
# • [evhz]
#   https://git.sr.ht/~iank/evhz
#
# • [xclicker]
#   https://xclicker.xyz/
#
# Used Home Manager options:
#───────────────────────────
# • https://nix-community.github.io/home-manager/options.xhtml#opt-wayland.windowManager.hyprland.settings

{ config, pkgs, ... }: {

	# Mouse and touchpad packages.
	environment.systemPackages = [
		# Show mouse refresh rate under linux + evdev.
		pkgs.evhz

		# Fast gui autoclicker for x11/xwayland linux apps.
		pkgs.xclicker
	];

	# Mouse and touchpad settings for the Hyprland Wayland compositor.
	home-manager.users.${config.custom.name}.wayland.windowManager.hyprland.settings.input = {
		# Sets the cursor acceleration profile.
		# Can be one of adaptive, flat. Can also be custom, see below.
		# https://wiki.hyprland.org/Configuring/Variables/#custom-accel-profiles
		# Leave empty to use libinput’s default mode for your input device.
		# https://wayland.freedesktop.org/libinput/doc/latest/pointer-acceleration.html#pointer-acceleration
		accel_profile = "flat";

		# Sets the scroll method.
		# Can be one of 2fg (2 fingers), edge, on_button_down, no_scroll.
		# https://wayland.freedesktop.org/libinput/doc/latest/scrolling.html
		scroll_method = "2fg";

		# More specific touchpad settings.
		touchpad = {
			# Whether to disable the touchpad while typing.
			disable_while_typing = false;

			# Button presses with 1, 2, or 3 fingers will be mapped to LMB, RMB, and MMB respectively.
			# This disables interpretation of clicks based on location on the touchpad.
			# https://wayland.freedesktop.org/libinput/doc/latest/clickpad-softbuttons.html#clickfinger-behavior
			clickfinger_behavior = true;
		};
	};

}
