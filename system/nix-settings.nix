{ config, lib, pkgs, ... }: {
	# Whether Nix should automatically replace files in store that have
	# identical content with hard links to a single copy, saving disk space.
	nix.settings.auto-optimise-store = true;

	# Whether to allow installation of unfree/proprietary software.
	nixpkgs.config.allowUnfree = true;

	environment = {
		# Whether to allow installation of unfree/proprietary software globally.
		sessionVariables.NIXPKGS_ALLOW_UNFREE = lib.mkIf config.nixpkgs.config.allowUnfree "1";

		systemPackages = with pkgs; [
			# Check hydra for the build status of a package.
			hydra-check

			# Processes output of Nix commands to show helpful and pretty information.
			nix-output-monitor
		];
	};

	# Nix-related shell abbreviations.
	# If nix-output-monitor is installed, it is used to make output better.
	programs.fish.shellAbbrs = {
		nix-list-generations = "run0 nixos-rebuild list -generations";
		download-nixos = ''wget -v https://channels.nixos.org/nixos-unstable/latest-nixos-graphical-x86_64-linux.iso'';
		download-mininixos = ''wget -v https://channels.nixos.org/nixos-unstable/latest-nixos-minimal-x86_64-linux.iso'';
	} // (if (lib.elem pkgs.nix-output-monitor config.environment.systemPackages) then {
		nix-update-now = "run0 nixos-rebuild switch --log-format internal-json 2>&1 | nom --json";
		nix-update-boot = "run0 nixos-rebuild boot --log-format internal-json 2>&1 | nom --json";
		nix-upgrade-now = "run0 nixos-rebuild switch --upgrade --log-format internal-json 2>&1 | nom --json";
		nix-upgrade-boot = "run0 nixos-rebuild boot --upgrade --log-format internal-json 2>&1 | nom --json";
		nix-rollback-now = "run0 nixos-rebuild switch --rollback --log-format internal-json 2>&1 | nom --json";
		nix-rollbcak-boot = "run0 nixos-rebuild boot --rollbcak --log-format internal-json 2>&1 | nom --json";
		nix-clean = "run0 nix-collect-garbage -d --log-format internal-json 2>&1 | nom --json";
		nix-clean-user = "nix-collect-garbage -d --log-format internal-json 2>&1 | nom --json";
		nix-test = ''set -x CURRENTDIR $(pwd) && cd /tmp/ && run0 nixos-rebuild test --log-format internal-json 2>&1 | nom --json; cd "$CURRENTDIR"'';
		nix-build-iso = "nix-build '<nixpkgs/nixos>' -A config.system.build.isoImage -I nixos-config=configuration.nix --log-format internal-json 2>&1 | nom --json && cp -v -i result/iso/*.iso ./ && run0 nix-store --delete --ignore-liveness $(readlink -f result/)";
	} else {
		nix-update-now = "run0 nixos-rebuild switch --log-format bar-with-logs";
		nix-update-boot = "run0 nixos-rebuild boot --log-format bar-with-logs";
		nix-upgrade-now = "run0 nixos-rebuild switch --upgrade --log-format bar-with-logs";
		nix-upgrade-boot = "run0 nixos-rebuild boot --upgrade --log-format bar-with-logs";
		nix-rollback-now = "run0 nixos-rebuild switch --rollback --log-format bar-with-logs";
		nix-rollbcak-boot = "run0 nixos-rebuild boot --rollbcak --log-format bar-with-logs";
		nix-clean = "run0 nix-collect-garbage -d --log-format bar-with-logs";
		nix-clean-user = "nix-collect-garbage -d --log-format bar-with-logs";
		nix-test = ''set -x CURRENTDIR $(pwd) && cd /tmp/ && run0 nixos-rebuild test --log-format bar-with-logs; cd "$CURRENTDIR"'';
		nix-build-iso = "nix-build '<nixpkgs/nixos>' -A config.system.build.isoImage -I nixos-config=configuration.nix --log-format bar-with-logs && cp -v -i result/iso/*.iso ./ && run0 nix-store --delete --ignore-liveness $(readlink -f result/)";
	});

	# Version of NixOS initially installed on the device.
	# This should never be changed post-installation.
	# It should only be changed on a clean install if you know what you are doing.
	system.stateVersion = "26.11";

	# Allow users in the wheel group to edit files in `/etc/nixos/`,
	# and that, without asking for a password every time.
	systemd.tmpfiles.rules = [ "Z /etc/nixos 0770 root wheel - -" ];
}