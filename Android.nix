{ config, pkgs, ... }: {

	environment.systemPackages = with pkgs; [
		# Reverse tethering over ADB for Android.
		gnirehtet

		# Cross-platform tool suite to flash firmware onto Samsung Galaxy devices.
		heimdall

		# Implementation of Microsoft's Media Transfer Protocol.
		libmtp

		# Display and control Android devices over USB or TCP/IP
		scrcpy
	];

	# Overlay for heimdall to use a newer version from a fork.
	# https://github.com/NixOS/nixpkgs/issues/393181
	nixpkgs.overlays = [(final: prev: {
		heimdall = prev.heimdall.overrideAttrs (
			old: { src = builtins.fetchFromSourcehut "https://git.sr.ht/~grimler/Heimdall"; }
		);
	})];

	# Whether to enable the use of the Android Debug Bridge (ADB).
	programs.adb.enable = true;

	# Adds the current user to the ADB users group.
	users.users.${config.custom.name}.extraGroups = [ "adbusers" ];

}
