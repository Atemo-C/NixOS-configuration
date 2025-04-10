# https://github.com/NixOS/nixpkgs/issues/361592
{ config, ... }: { security.pam.services.systemd-run0 = {

	setEnvironment = true;
	pamMount = false;

}; }
