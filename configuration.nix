{ config, ... }: { imports = [

	# Automatically-generated hardware setting module.
	./hardware-configuration.nix

	# Additional modifications/overrides to `hardware-configuration.nix`.
#	./Hardware-overrides.nix

	# Temporary fixes.
	./Temporary.nix

	# Support and interaction with Android devices.
	./Android.nix

	# Audio settings and packages.
	./Audio.nix

	# Bluetooth settings.
	./Bluetooth.nix

	# Boot settings.
	./Boot.nix

	# Linux Console (TTY) settings.
	./Console.nix

	# Desktop components.
	./Desktop/Dependencies.nix # XDG-DP & Dconf.
	./Desktop/Dunst.nix        # Notifications.
	./Desktop/Hyprland.nix     # Wayland compositor.
	./Desktop/Menus.nix        # Menus for scripts, run launchers, and file selection.
	./Desktop/Utilities.nix    # Wallpaper, keyring, polkit agent…
	./Desktop/Waybar.nix       # Desktop bar.

	# Time settings.
	./Time.nix

	# Font settings.
	./Fonts.nix

	# GPU modules.
	# A boot entry for 16XX> NVIDIA GPUs is added when `NVIDIA.nix` is used.
	# Unfortunately, it is not currently possible to make a specialisation the default entry in the bootloader.
	# https://github.com/NixOS/nixpkgs/issues/146641
	#
	# In the `Shared.nix` module, you can configure which non-NVIDIA elements you want to be installed.
	./GPU/Shared.nix
	./GPU/NVIDIA.nix

	# Input modules.
	./Input/Fcitx5.nix           # Input method framework.
	./Input/OpenTabletDriver.nix # For drawing tablets.
	./Input/Power-button.nix     # Actions upon power buttons press.
	./Input/Utilities.nix        # Game controller tester, mouse refresh rate settings…
	./Input/ZSA.nix              # For ZSA keyboards.

	# Linux Kernel settings.
	./Kernel.nix

	# Keyboard layout.
	./Layout.nix

	# System locale.
	./Locale.nix

	# Monitor/s (screen/s) settings.
	./Monitors.nix

	# Networking settings.
	./Networking.nix

	# Nix and NixOS-related settings.
	./Nix-settings.nix

	# Packaging modules.
	./Packaging/Nix.nix
	./Packaging/Universal.nix
	./Packaging/Windows.nix

	# Power modules.
#	./Power/Alternative-suspend.nix
	./Power/Power.nix

	# Printing module and additional drivers.
	./Printing.nix

	# Modules to install and configure various packages onto the system.
	./Programs/3D.nix
	./Programs/Accessories.nix
	./Programs/Gaming.nix
	./Programs/Gstreamer.nix
	./Programs/Images.nix
	./Programs/Internet.nix
	./Programs/Office.nix
	./Programs/System-info.nix
	./Programs/Terminal-emulators.nix
	./Programs/Terminal-utilities.nix
	./Programs/Text.nix
	./Programs/Video.nix

	# OpenSSH module.
	./SSH.nix

	# Storage and file management modules.
	./Storage/File-management.nix
	./Storage/File-utilities.nix
	./Storage/Filesystem-services.nix
	./Storage/Filesystem-settings.nix
	./Storage/Filesystem-support.nix
	./Storage/Optical-media.nix
	./Storage/Storage-mounts.nix

	# Theming.
	./Theming/Program-themes.nix
	./Theming/Icon-themes.nix
	./Theming/Settings.nix

	# User modules.
	./User/Home-manager.nix
	./User/Name.nix
	./User/Name-module.nix
	./User/Settings.nix
	./User/Shell.nix

	# Host virtualisation modules.
#	./Virtualisation/Host/Docker.nix
#	./Virtualisation/Host/Virt-manager.nix
#	./Virtualisation/Host/Virtualbox.nix
#	./Virtualisation/Host/Waydroid.nix

	# Guest virtualisation modules.
#	./Virtualisation/Guest/QEMU-KVM.nix
#	./Virtualisation/Guest/VMWare.nix
#	./Virtualisation/Guest/HyperV.nix
#	./Virtualisation/Guest/XE.nix
#	./Virtualisation/Guest/VirtualBox.nix

]; }
