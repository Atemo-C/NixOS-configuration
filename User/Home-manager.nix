# Documentation:
#───────────────
# • https://wiki.nixos.org/wiki/Home_Manager
#
# Used Home Manager options:
#───────────────────────────
# • [Link doesn't exist] https://nix-community.github.io/home-manager/options.xhtml#opt-backupFileExtension
# • https://nix-community.github.io/home-manager/options.xhtml#opt-home.stateVersion

{ config, pkgs, ... }:

# Adds Home Manager. Its version should match the installed NixOS version.
let
	home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz";
in {
	imports = [ "${home-manager}/nixos" ];

	home-manager = {
		# Automatic backup of conflicting configuration files.
		backupFileExtension = "backup";

		# Home Manager version.
		users.${config.custom.name}.home.stateVersion = "${config.system.stateVersion}";
	};

}
