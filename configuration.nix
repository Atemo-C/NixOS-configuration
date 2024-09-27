{ ... }: { imports = [

	# Automatically generated hardware configuration module.
	./hardware-configuration.nix

	# Android modules.
	./Android/ADB.nix
	./Android/Utilities.nix

	# Audio module.
	./Audio.nix

	# Bluetooth module.
#	./Bluetooth.nix

	# Boot modules.
	./Boot/Autostart.nix
#	./Boot/EFI.nix
#	./Boot/BIOS.nix

	# Desktop modules.
	./Desktop/Bar.nix
	./Desktop/Dconf.nix
	./Desktop/Hyprland-settings.nix
	./Desktop/Hyprland.nix
	./Desktop/Menus.nix
	./Desktop/Notifications.nix
	./Desktop/Utilities.nix
	./Desktop/XDG.nix

	# Driver modules.
#	./Drivers/NVIDIA.nix
	./Drivers/General-graphics.nix

	# File management modules.
	./Files/Management.nix
	./Files/Services.nix
	./Files/Sharing.nix
	./Files/Utilities.nix

	# Time module.
	./Time.nix

	# Fonts module.
	./Fonts.nix

	# Gaming modules.
	./Gaming/Emulation.nix
	./Gaming/Games.nix
	./Gaming/Settings.nix
	./Gaming/Steam.nix
	./Gaming/Utilities.nix

	# Input modules.
	./Input/Bindings.nix
	./Input/Controller.nix
	./Input/Keyboard.nix
	./Input/Mouse-and-touchpad.nix
	./Input/Power.nix
	./Input/Tablet.nix
	./Input/Utilities.nix

	# Linux Kernel module.
	./Kernel.nix

	# Networking module.
	./Networking.nix

	# Packaging modules.
	# System.nix also contains the state version.
	./Packaging/System.nix
	./Packaging/System-unstable.nix
	./Packaging/Universal.nix

	# Power modules.
	./Power/Powersaving.nix
	./Power/Utilities.nix

	# Printing & scanning modules.
	./Printing/General.nix
#	./Printing/HP.nix

	# Programs modules.
	./Programs/3D.nix
	./Programs/Accessories.nix
	./Programs/Audio.nix
	./Programs/Gstreamer.nix
	./Programs/Images.nix
	./Programs/Internet.nix
	./Programs/Office.nix
	./Programs/Sysinfo.nix
	./Programs/Terminal-emulators.nix
	./Programs/Terminal-utilities.nix
	./Programs/Text.nix
	./Programs/Video.nix

	# SSH module.
	./SSH.nix

	# Storage modules.
	./Storage/Filesystems.nix
#	./Storage/Mounts.nix
	./Storage/Optical.nix
	./Storage/Settings.nix

	# Theming modules.
	./Theming/Icons.nix
	./Theming/Settings.nix
	./Theming/TTY.nix

	# User modules.
	./User/Home-manager.nix
	./User/Name.nix
	./User/Settings.nix
	./User/Shell.nix

	# Virtualisation modules.
#	./Virtualisation/Docker.nix
#	./Virtualisation/Virt-manager.nix
#	./Virtualisation/Virtualbox.nix
#	./Virtualisation/Waydroid.nix

]; }
