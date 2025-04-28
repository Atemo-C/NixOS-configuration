{ config, ... }: { imports = [

	# Android utilities.
	./Android.nix

	# Audio configuration & utilities.
	./Audio.nix

	# Bluetooth configuration.
#	./Bluetooth.nix

	# Boot configuration.
	./Boot.nix

	# Hyprland desktop modules (main desktop).
	./Desktop/Hyprland/Dependencies.nix # XDG Desktop Portals & Dconf.
	./Desktop/Hyprland/Dunst.nix        # Desktop notifications.
	./Desktop/Hyprland/Hyprland.nix     # Hyprland Wayland compositor.
	./Desktop/Hyprland/Menus.nix        # Tofi menu & Zenity graphical dialogue tool.
	./Desktop/Hyprland/Utilities.nix    # Wallpaper, keyring…
	./Desktop/Hyprland/Waybar.nix       # Desktop bar.

	# XFCE desktop modules (mostly here for debugging/rescue and VMs).
#	./Desktop/XFCE/Panel.nix
#	./Desktop/XFCE/XFCE.nix

	# Font settings.
	./Fonts.nix

	# GPU modules.
	# If `NVIDIA.nix` is enabled, a boot entry for 16XX> NVIDIA GPUs is added.
	# Unfortunately, it is currently impossible to make a specialisation be the default entry in the booloader.
	# See https://github.com/NixOS/nixpkgs/issues/146641
	./GPU/Shared.nix
	./GPU/NVIDIA.nix

	# Automatically-generated hardware setting module.
	./hardware-configuration.nix

	# Additional modifications/overrides to `hardware-configuration.nix`.
#	./Hardware-overrides.nix

	# Input modules.
	./Input/Fcitx5.nix           # Input method framework.
	./Input/Keyboard-layout.nix  # Keyboard layout.
#	./Input/OpenTabletDriver.nix # For drawing tablets.
	./Input/Power-button.nix     # Actions upon power buttons press.
	./Input/Utilities.nix        # Game controller tester, mouse refresh rate settings…
#	./Input/ZSA.nix              # For ZSA keyboards.

	# Linux Kernel settings.
	./Kernel.nix

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
#	./Storage/Storage-mounts.nix

	# Temporary fixes.
	./Temporary.nix

	# Theming.
	./Theming/Terminal-colors.nix
	./Theming/Program-themes.nix
	./Theming/Icon-themes.nix
	./Theming/Settings.nix

	# Time settings.
	./Time.nix

	# User modules.
	./User/Home-manager.nix
	./User/Name.nix
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
