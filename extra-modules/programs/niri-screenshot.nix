{ config, lib, ... }: {
	options.programs.niri-screenshot.enable = lib.mkEnableOption
	"a shell utility to facilitate and enhance taking screenshots in Niri.";

	imports = [ ../scripts/niri-screenshot.nix ];
}