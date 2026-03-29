{ config, lib, pkgs, ... }: let cfg = config.programs.acpi; in {
	options.programs.acpi.enable = lib.mkEnableOption "acpi, a utility to show battery status and other ACPI information.";

	config.environment.systemPackages = lib.optional cfg.enable pkgs.acpi;
}