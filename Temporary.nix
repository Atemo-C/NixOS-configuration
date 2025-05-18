# Temporary fixes with relevant links to the relevant issues.
#
# • On the top, you will find active fixes/workarounds.
# • On the bottom, you will find inactive ones, mostly here to remind me how to fix stuff.

{ config, pkgs, ... }: {

	# https://github.com/NixOS/nixpkgs/issues/361592
	security.pam.services.systemd-run0 = {
		setEnvironment = true;
		pamMount = false;
	};

}








# https://github.com/NixOS/nixpkgs/issues/404912
# https://github.com/NixOS/nixpkgs/pull/404963
#	nixpkgs.overlays = [
#		(self: super: {
#			mcpelauncher-client = super.mcpelauncher-client.overrideAttrs (oldAttrs: {
#				version = "1.3.0-qt6";
#				src = oldAttrs.src.override {
#					hash = "sha256-/I6hCnRSFHX30Gd0jErx5Uy/o8JCdYexsMRDKMUOWWI=";
#				};
#			});
#		})
#		(self: super: {
#			mcpelauncher-ui-qt = super.mcpelauncher-ui-qt.overrideAttrs (oldAttrs: {
#				src = oldAttrs.src.override {
#					hash = "sha256-333PwfBWhdfJSi1XrJNHidMYZrzSReb8s4VxBASFQ6Q=";
#				};
#			});
#		})
#	];
