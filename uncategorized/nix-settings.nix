{ config, lib, ... }: {
	nix.settings = {
		auto-optimise-store = true;
		download-buffer-size = 629145600;
		experimental-features = [ "nix-command" ];
	};

	programs.hydra-check.enable = true;

	security = {
		sudo.enable = false;
		run0.enableSudoAlias = lib.mkIf (! config.security.sudo.enable) true;
	};

	system.stateVersion = "26.05";
	systemd.tmpfiles.rules = [ "Z /etc/nixos 0770 root wheel - -" ];
}