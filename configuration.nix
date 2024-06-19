{ ... }: {

	imports = [
		./hardware-configuration.nix

		./Android/ADB.nix
		./Android/Tools.nix

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

		./Gaming/Driving.nix
		./Gaming/Emulators
		./Gaming/Gamemode
		./Gaming/Gamescope
		./Gaming/Minecrafty
		./Gaming/Steam
		./Gaming/System-tweaks.nix

#		./GPU/AMD.nix
#		./GPU/Intel.nix
#		./GPU/Nvidia.nix
#		./GPU/Nvidia-nouveau.nix

		./Hyprland/Other-utilties.nix
		./Hyprland/Settings.nix
		./Hyprland/Tools.nix
		./Hyprland/XDG-portal.nix

		./Input/Controllers.nix
		./Input/Utilities.nix

		./Input/Buttons/Power.nix
		./Input/Drawing/OpenTabletDriver.nix
		./Input/Keyboard/Layout.nix
		./Input/Keyboard/ZSA.nix
		./Input/Mouse/Autoclicker.nix
		./Input/Mouse/Utilities.nix

		./Internet/Social.nix
		./Internet/Downloading.nix
		./Internet/Gemini.nix
		./Internet/Email.nix
		./Internet/Web.nix

		./Kernel/Version.nix

		./Locale/Locale.nix
		./Locale/Extra-settings.nix

		./Media/3D.nix
		./Media/Gstreamer.nix

		./Media/Audio/Editing.nix
		./Media/Audio/Music.nix
		./Media/Audio/Settings.nix
		./Media/Audio/Utilities.nix

		./Media/Image/Editing.nix
		./Media/Image/Formats.nix
		./Media/Image/Picker.nix
		./Media/Image/Utilities.nix
		./Media/Image/Viewier.nix

		./Media/Video/Capture.nix
		./Media/Video/Editor.nix
		./Media/Video/Player.nix
		./Media/Video/Utilities.nix
		./Media/Video/V4L2.nix

		./Networking/Hostname.nix
		./Networking/NetworkManager.nix

		./Office/Suite.nix
		./Office/Reader.nix

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

#		./Virtualisation/Docker.nix
#		./Virtualisation/Virt-manager.nix
#		./Virtualisation/Virtualbox.nix
	];

}
