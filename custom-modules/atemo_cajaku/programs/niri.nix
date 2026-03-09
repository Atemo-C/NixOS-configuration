# Original module:
# https://github.com/NixOS/nixpkgs/blob/nixos-unstable/nixos/modules/programs/wayland/niri.nix
{ config, lib, pkgs, ... }: let cfg = config.programs.niri.xwayland; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.niri.xwayland = lib.mkEnableOption
		"support for XWayland with the help of the xwayland-satellite package."
		{ default = true; };

	config.environment.systemPackages = lib.optional cfg.xwayland pkgs.xwayland-satellite;
}