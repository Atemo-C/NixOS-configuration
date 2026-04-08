{ config, lib, pkgs, ... }: let cfg = config.programs.niri; in {
	options.programs.niri = {
		gsettingsWorkarounds = lib.mkEnableOption "workarounds to gsettings schemas sourcing and configuration. See https://github.com/NixOS/nixpkgs/issues/149812 and https://github.com/thomX75/nixos-modules/blob/main/Glib-Schemas-Fix/glib-schemas-fix.nix for more details." //
		{ default = true; };

		linkConfiguration = lib.mkOption {
			type = lib.types.bool;
			default = false;
			description = "Whether to link Niri's configuration directory, from `/etc/nixos/desktop/files/niri/ to ~/.config/niri/";
		};

		xwaylandSatellite = lib.mkEnableOption "support for XWayland with the XWayland Satellite." //
		{ default = true; };
	};

	config = lib.mkIf cfg.enable {
		programs.dconf.enable = true;

		hardware.graphics = {
			enable = true;
			enable32Bit = true;
		};

		environment = {
			extraInit = lib.mkIf cfg.gsettingsWorkarounds ''export XDG_DATA_DIRS="$XDG_DATA_DIRS:${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"'';

			variables.GSETTINGS_SCHEMA_DIR = lib.mkIf cfg.gsettingsWorkarounds "${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}/glib-2.0/schemas";
		};

		systemd.user.tmpfiles.users.${config.user.name}.rules = lib.optional cfg.linkConfiguration "L %h/.config/niri/ - - - - /etc/nixos/desktop/files/niri/";

		systemPackages = lib.optional cfg.xwaylandSatellite pkgs.xwayland-satellite;
	};
}