# Original module:
# https://github.com/NixOS/nixpkgs/blob/nixos-unstable/nixos/modules/programs/wayland/niri.nix
{ config, lib, pkgs, ... }: let cfg = config.programs.niri; in {
	options.programs.niri = {
		gsettingsWorkarounds = lib.mkEnableOption "apply workarounds to gsettings schemas sourcing and configuration. See https://github.com/NixOS/nixpkgs/issues/149812 for more details.";

		linkConfiguration = lib.mkOption {
			type = lib.types.bool;
			default = false;
			description = "Whether to link Niri's configuration directory, from /etc/nixos/desktop/files/niri/ to ~/.config/niri/";
		};

		xwayland = lib.mkEnableOption "support for XWayland by using the XWayland Satellite.";
	};

	config = lib.mkIf cfg.enable {
		programs.dconf.enable = true;

		hardware.graphics = {
			enable = true;
			enable32Bit = true;
		};

		environment = {
			systemPackages = lib.optional cfg.xwayland pkgs.xwayland-satellite;

			extraInit = lib.mkIf cfg.gsettingsWorkarounds ''export XDG_DATA_DIRS="$XDG_DATA_DIRS:${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"'';

			variables.GSETTINGS_SCHEMA_DIR = lib.mkIf cfg.gsettingsWorkarounds "${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}/glib-2.0/schemas";
		};

		systemd.user.tmpfiles.users.${config.user.name}.rules = lib.optional cfg.linkConfiguration "L %h/.config/niri/ - - - - /etc/nixos/desktop/files/niri/";
	};
}