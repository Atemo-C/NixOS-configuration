# Original module:
# https://github.com/NixOS/nixpkgs/blob/nixos-unstable/nixos/modules/programs/wayland/niri.nix
{ config, lib, pkgs, ... }: let cfg = config.programs.niri; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.niri.xwaylandSupport = lib.mkEnableOption
		"support for XWayland with the help of the xwayland-satellite package."
		{ default = true; };

	config = lib.mkIf cfg.enable; {
		# Install the XWayland satellite for XWayland support.
		environment.systemPackages = lib.optional cfg.xwaylandSupport pkgs.xwayland-satellite;

		# Enable Dconf.
		programs.dconf.enable = true;

		# Enable 3D graphics acceleration for both normal and 32-bit programs.
		hardware.graphics = {
			enable = true;
			enable32Bit = true;
		};
}