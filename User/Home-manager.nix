{ config, pkgs, ... }: let home-manager = builtins.fetchTarball
"https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz";
in {#                                                          ^---^
	# Import the Home Manager module.
	imports = [ (import "${home-manager}/nixos") ];

	# Home Manager settings.
	home-manager = {
		# Backup file extension to use when backing up files replaced by Home Manager.
		backupFileExtension = "HM-Backup";

		# State version of Home Manager.
		# Here, it is assumed that Home Manager was installed with the same version used to install NixOS.
		users.${config.custom.name}.home.stateVersion = "${config.system.stateVersion}";
	};
}
