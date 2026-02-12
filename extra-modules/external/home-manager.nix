{ config, ... }: let
	home-manager = builtins.fetchTarball
	"https://github.com/nix-community/home-manager/archive/master.tar.gz";
in {
	# Import the Home Manager module for NixOS.
	imports = [ (import "${home-manager}/nixos") ];

	home-manager = {
		# The name extension added to files Home Manager backs up.
		backupFileExtension = "hm-backup";

		users = {
			# Version of Home Manager first installed on the system.
			# Here, it is assumed that it is the same as NixOS.
			${config.userName}.home.stateVersion = "${config.system.stateVersion}";
			root.home.stateVersion = "${config.system.stateVersion}";
		};
	};
}