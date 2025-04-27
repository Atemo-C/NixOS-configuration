# Temporary fixes with relevant links to related issues.
{ config, pkgs, ... }: {

	# https://github.com/NixOS/nixpkgs/issues/361592
	security.pam.services.systemd-run0 = {
		setEnvironment = true;
		pamMount = false;
	};

}
