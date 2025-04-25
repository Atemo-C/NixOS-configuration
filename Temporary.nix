{ config, pkgs, ... }: {

	# https://github.com/NixOS/nixpkgs/issues/361592
	security.pam.services.systemd-run0 = {
		setEnvironment = true;
		pamMount = false;
	};

	# https://github.com/NixOS/nixpkgs/issues/399907
	# Fixed by https://github.com/NixOS/nixpkgs/pull/400139, merged into nixpkgs-unstable.
	# Waiting some time before removing.
	nixpkgs.overlays = [
		(final: prev: {
			qt6Packages = prev.qt6Packages.overrideScope (_: kprev: {
				qt6gtk2 = kprev.qt6gtk2.overrideAttrs (_: {
					version = "0.5-unstable-2025-03-04";
					src = final.fetchFromGitLab {
						domain = "opencode.net";
						owner = "trialuser";
						repo = "qt6gtk2";
						rev = "d7c14bec2c7a3d2a37cde60ec059fc0ed4efee67";
						hash = "sha256-6xD0lBiGWC3PXFyM2JW16/sDwicw4kWSCnjnNwUT4PI=";
					};
				});
			});
		})
	];
	home-manager.users.${config.custom.name}.nixpkgs.overlays = [
		(final: prev: {
			qt6Packages = prev.qt6Packages.overrideScope (_: kprev: {
				qt6gtk2 = kprev.qt6gtk2.overrideAttrs (_: {
					version = "0.5-unstable-2025-03-04";
					src = final.fetchFromGitLab {
						domain = "opencode.net";
						owner = "trialuser";
						repo = "qt6gtk2";
						rev = "d7c14bec2c7a3d2a37cde60ec059fc0ed4efee67";
						hash = "sha256-6xD0lBiGWC3PXFyM2JW16/sDwicw4kWSCnjnNwUT4PI=";
					};
				});
			});
		})
	];
	home-manager.users.root.nixpkgs.overlays = [
		(final: prev: {
			qt6Packages = prev.qt6Packages.overrideScope (_: kprev: {
				qt6gtk2 = kprev.qt6gtk2.overrideAttrs (_: {
					version = "0.5-unstable-2025-03-04";
					src = final.fetchFromGitLab {
						domain = "opencode.net";
						owner = "trialuser";
						repo = "qt6gtk2";
						rev = "d7c14bec2c7a3d2a37cde60ec059fc0ed4efee67";
						hash = "sha256-6xD0lBiGWC3PXFyM2JW16/sDwicw4kWSCnjnNwUT4PI=";
					};
				});
			});
		})
	];
}
