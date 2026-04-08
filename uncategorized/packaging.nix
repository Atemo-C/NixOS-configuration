{ config, lib, ... }: {
	nixpkgs.config.allowUnfree = true;
	environment.sessionVariables.NIXPKGS_ALLOW_UNFREE = lib.mkIf config.nixpkgs.config.allowUnfree "1";
}