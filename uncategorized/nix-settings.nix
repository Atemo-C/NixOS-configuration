{ config, lib, ... }: {
	nix.settings = {
		auto-optimise-store = true;
		download-buffer-size = 629145600;
		experimental-features = [ "nix-command" ];
	};

	programs = {
		hydra-check.enable = true;
		nix-output-monitor.enable = true;

		fish.shellAbbrs = rec {
			nix-test = ''set -x CURRENTDIR $(pwd) && cd /tmp/ && run0 nixos-rebuild test --log-format internal-json -v 2>&1 | nom --json; cd "$CURRENTDIR"'';
			nix-update-now = "run0 nixos-rebuild switch --log-format internal-json -v 2>&1 | nom --json";
			nix-update-boot = "run0 nixos-rebuild boot --log-format internal-json -v 2>&1 | nom --json";
			nix-upgrade-now = "run0 nixos-rebuild switch --upgrade --log-format internal-json -v 2>&1 | nom --json";
			nix-upgrade-boot = "run0 nixos-rebuild boot --upgrade --log-format internal-json -v 2>&1 | nom --json";
			nix-clean = "run0 nix-collect-garbage -d --log-format internal-json -v 2>&1 | nom --json && nix-collect-garbage -d --log-format internal-json -v 2>&1 | nom --json";
			nix-list-generation = "run0 nixos-rebuild list -generations";
			mk-nixiso = "run0 nix-build '<nixpkgs/nixos>' -A config.system.build.isoImage -I nixos-config=iso.nix --log-format internal-json -v 2>&1 | nom --json";
			rm-nixiso = "run0 nix-store --delete --ignore-liveness $(readlink -f result/)";
			download-nixos = ''wget -v "https://channels.nixos.org/nixos-unstable/latest-nixos-graphical-x86_64-linux.iso'';
			download-nixos-minimal = ''wget -v "https://channels.nixos.org/nixos-unstable/latest-nixos-minimal-x86_64-linux.iso'';
		};
	};

	security = {
		sudo.enable = false;
		run0.enableSudoAlias = lib.mkIf (! config.security.sudo.enable) true;
	};

	system.stateVersion = "26.05";
	systemd.tmpfiles.rules = [ "Z /etc/nixos 0770 root wheel - -" ];
}