{ config, ... }: {

	custom = {
		# Name of the current user.
		# [a-z] [A-Z] [0-9] [ - _ ]
		name = "user-name";

		# Title of the current user.
		title = "User title";
	};

	# Name of the current system.
	# [a-z] [A-Z] [0-9] [ - ]
	networking.hostName = "COMPUTER-NAME";

	# Which version of NixOS was initially installed on the current system.
	# There is no need to change it post-installation, even when upgrading to a newer NixOS version.
	system.stateVersion = "24.11";

	imports = [
		# Automatically generated hardware configuration module.
		./hardware-configuration.nix

		# Android module.
		./Android.nix

		# Audio module.
		./Audio.nix

		# Bluetooth module.
#		./Bluetooth.nix

		# Boot modules.
		./Boot/Boot.nix
#		./Boot/Monitors.nix

		# Linux console (TTY) module.
		./Console.nix

		# Desktop modules.
		./Desktop/Bar.nix
		./Desktop/Dconf.nix
		./Desktop/Hyprland.nix
		./Desktop/Menus.nix
		./Desktop/Notifications.nix
		./Desktop/Utilities.nix
		./Desktop/XDG.nix

		# Time module.
		./Time.nix

		# Fonts module.
		./Fonts.nix

		# Gaming modules.
		./Gaming/Emulation.nix
		./Gaming/Games.nix
		./Gaming/Gaming-tweaks.nix
		./Gaming/Gaming-utilities.nix
		./Gaming/Steam.nix

		# GPU modules. Select relevant ones; Shared-GPU-settings.nix is always enabled.
		./GPU/Shared-GPU-settings.nix
#		./GPU/NVIDIA.nix
#		./GPU/NVIDIA-CUDA-and-CDI.nix
#		./GPU/OpenCL-AMD.nix
#		./GPU/OpenCL-Intel.nix
#		./GPU/VA-API-Intel.nix

		# Input modules.
		./Input/IBus.nix
		./Input/Input-utilities.nix
		./Input/OpenTabletDriver.nix
		./Input/Power-button.nix
		./Input/ZSA.nix

		# Keyboard layout module.
		./Layout.nix

		# Locale module.
		./Locale.nix

		# Linux Kernel module.
		./Kernel.nix

		# Networking module.
		./Networking.nix

		# Packaging modules.
		./Packaging/General.nix
		./Packaging/Universal.nix
		./Packaging/Windows.nix

		# Power modules.
#		./Power/Alternative-suspend.nix
		./Power/Power.nix

		# Printing and scanning modules.
		./Printing/General-printing.nix
		./Printing/HP.nix

		# Programs modules.
		./Programs/3D.nix
		./Programs/Accessories.nix
		./Programs/Audio.nix
		./Programs/Gstreamer.nix
		./Programs/Images.nix
		./Programs/Internet.nix
		./Programs/Office.nix
		./Programs/System-info.nix
		./Programs/Terminal-emulators.nix
		./Programs/Terminal-utilities.nix
		./Programs/Text.nix
		./Programs/Video.nix

		# SSH module.
		./SSH.nix

		# Storage and file management modules.
		./Storage/File-management.nix
#		./Storage/File-sharing.nix
		./Storage/File-utilities.nix
		./Storage/Filesystems-services.nix
		./Storage/Filesystems-settings.nix
		./Storage/Filesystems-support.nix
		./Storage/Optical-media.nix
#		./Storage/Storage-mounts.nix

		# Theming modules.
		./Theming/Application-theme.nix
		./Theming/Icons.nix
		./Theming/Settings.nix

		# User modules.
		./User/Home-manager.nix
		./User/Name-module.nix
		./User/User-settings.nix
		./User/Shell.nix

		# Virtualisation modules.
#		./Virtualisation/Docker.nix
#		./Virtualisation/Docker-NVIDIA.nix
#		./Virtualisation/Virt-manager.nix
#		./Virtualisation/Virtualbox.nix
#		./Virtualisation/Waydroid.nix

		# Virtualisation modules for guest agents.
#		./Guest-virt/QEMU-KVM.nix
#		./Guest-virt/VMWare.nix
#		./Guest-virt/HyperV.nix
#		./Guest-virt/XE.nix
#		./Guest-virt/VirtualBox.nix
	];

}
