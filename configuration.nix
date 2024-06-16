{ config, ... }: {

	imports = [
		./hardware-configuration.nix

		./Boot/EFI.nix
		./Boot/Entries.nix
		./Boot/Security.nix
		./Boot/SystemD-boot.nix
		./Boot/Timeout.nix

#		./GPU/AMD.nix
#		./GPU/Intel.nix

		./Input/Drawing/OpenTabletDriver.nix
		./Input/Keyboard/Layout.nix
		./Input/Keyboard/ZSA.nix

		./Networking/Hostname.nix
		./Networking/NetworkManager.nix

		./Packages/Unfree.nix
		./Packages/Unstable.nix

		./Packages/Text/Clipboard.nix
		./Packages/Text/Editor.nix
		./Packages/Text/Pickers.nix
		./Packages/Text/Spelling.nix

		./SSH/OpenSSH.nix
		./SSH/Permission.nix
		./SSH/Ports.nix

		./Storage/Additional-filesystems.nix
#		./Storage/Mounts.nix

		./System/Configuration-backup.nix
		./System/State-version.nix
		./System/Store-optimisation.nix

		./Time/Hardware-clock.nix
		./Time/Timezone.nix

		./User/Groups.nix
		./User/Name.nix
		./User/Settings.nix
		./User/Shell.nix
	];

}
