{ config, ... }: {

	imports = [
		./hardware-configuration.nix

		./Audio/Editing.nix
		./Audio/Music.nix
		./Audio/Settings.nix
		./Audio/Utilities.nix

		./Boot/EFI.nix
		./Boot/Entries.nix
		./Boot/Security.nix
		./Boot/SystemD-boot.nix
		./Boot/Timeout.nix

		./Fonts/Emoji.nix
		./Fonts/Monospace.nix
		./Fonts/Packages.nix
		./Fonts/SansSerif.nix
		./Fonts/Serif.nix
		./Fonts/Settings.nix

#		./GPU/AMD.nix
#		./GPU/Intel.nix

		./Input/Drawing/OpenTabletDriver.nix
		./Input/Keyboard/Layout.nix
		./Input/Keyboard/ZSA.nix

		./Networking/Hostname.nix
		./Networking/NetworkManager.nix

		./Packages/Unfree.nix
		./Packages/Unstable.nix

		./SSH/OpenSSH.nix
		./SSH/Permission.nix
		./SSH/Ports.nix

		./Storage/Additional-filesystems.nix
#		./Storage/Mounts.nix

		./System/Configuration-backup.nix
		./System/State-version.nix
		./System/Store-optimisation.nix

		./Text/Clipboard.nix
		./Text/Editor.nix
		./Text/Pickers.nix
		./Text/Spelling.nix

		./Time/Hardware-clock.nix
		./Time/Timezone.nix

		./User/Groups.nix
		./User/Name.nix
		./User/Settings.nix
		./User/Shell.nix
	];

}
