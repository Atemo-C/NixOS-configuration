{ config, ... }: let home-manager =
	builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in {
	# Import the Home Manager module.
	imports = [ (import "${home-manager}/nixos") ];

	# Backup file extension to use when backing up files replaced by Home Manager.
	home-manager.backupFileExtension = "HM-Backup";

	# State version of Home Manager.
	# Here, it is assumed that Home Manager was installed with the same version of NixOS that was installed.
	home-manager.users.${config.userName}.home.stateVersion = "${config.system.stateVersion}";
	home-manager.users.root.home.stateVersion = "${config.system.stateVersion}";
}