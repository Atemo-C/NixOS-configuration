{ config, ... }: {

	imports = [
		./hardware-configuration.nix

		./Boot/EFI.nix
		./Boot/Entries.nix
		./Boot/Security.nix
		./Boot/SystemD-boot.nix
		./Boot/Timeout.nix

		./Input/Drawing/OpenTabletDriver.nix
		./Input/Keyboard/Layout.nix
		./Input/Keyboard/ZSA.nix

		./GPU/AMD.nix
		./GPU/Intel.nix

		./Packages/Unfree.nix
		./Packages/Unstable.nix

		./Packages/Text/Clipboard.nix
		./Packages/Text/Editor.nix
		./Packages/Text/Pickers.nix
		./Packages/Text/Spelling.nix

		./SSH/OpenSSH.nix
		./SSH/Permission.nix
		./SSH/Ports.nix
	];

}
