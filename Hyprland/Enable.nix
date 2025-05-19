# Module that creates a variable to enable/disable the Hyprland Wayland compositor.
# It is really only here to avoid silly infinite recursion problems.

{ config, lib, ... }: { options.enableHyprland = lib.mkOption {

	# Set the type of the module (boolean).
	type = lib.types.bool;

	# The default state of the module.
	default = true;

	# Description of the module.
	description = "Whether to enable the Hyprland Wayland compositor. Only enable if XFCE is not enabled.";

}; }
