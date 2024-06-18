{ ... }: {

	imports = [
		./hardware-configuration.nix

		./Android/ADB.nix
		./Android/Tools.nix

		./Audio/Editing.nix
		./Audio/Music.nix
		./Audio/Settings.nix
		./Audio/Utilities.nix

#		./Bluetooth/Blueman.nix
#		./Bluetooth/Settings.nix

		./Boot/EFI.nix
		./Boot/Entries.nix
		./Boot/Security.nix
		./Boot/SystemD-boot.nix
		./Boot/Timeout.nix

#		./Computer/KVM-guest.nix
#		./Computer/Laptop.nix

		./Fonts/Emoji.nix
		./Fonts/Monospace.nix
		./Fonts/Packages.nix
		./Fonts/SansSerif.nix
		./Fonts/Serif.nix
		./Fonts/Settings.nix

#		./GPU/AMD.nix
#		./GPU/Intel.nix
#		./GPU/Nvidia.nix
#		./GPU/Nvidia-nouveau.nix

		./Hyprland/Settings.nix
		./Hyprland/Tools.nix
		./Hyprland/XDG-portal.nix

		./Input/Buttons/Power.nix
		./Input/Drawing/OpenTabletDriver.nix
		./Input/Keyboard/Layout.nix
		./Input/Keyboard/ZSA.nix

		./Internet/Social.nix
		./Internet/Downloading.nix
		./Internet/Gemini.nix
		./Internet/Email.nix
		./Internet/Web.nix

		./Kernel/Version.nix

		./Locale/Locale.nix
		./Locale/Extra-settings.nix

		./Networking/Hostname.nix
		./Networking/NetworkManager.nix

		./Packaging/AppImage.nix
		./Packaging/Flatpak.nix
		./Packaging/Unfree.nix
		./Packaging/Unstable.nix

		./Printing/General.nix
		./Printing/HP.nix
		./Printing/Packages.nix

		./SSH/OpenSSH.nix
		./SSH/Permission.nix
		./SSH/Ports.nix

		./Storage/Additional-filesystems.nix
		./Storage/BTRFS-autoscrub.nix
#		./Storage/SSD-TRIM.nix
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

		./TTY/Colors.nix
		./TTY/Settings.nix

		./User/Groups.nix
		./User/Name.nix
		./User/Name-module.nix
		./User/Settings.nix
		./User/Shell.nix

		./User/Home-manager/Module.nix
		./User/Home-manager/Settings.nix

		./Video/Player.nix
		./Video/Editor.nix
		./Video/Utilities.nix
		./Video/Capture.nix

#		./Virtualisation/Docker.nix
#		./Virtualisation/Virt-manager.nix
#		./Virtualisation/Virtualbox.nix
	];

}
