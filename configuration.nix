# NixOS configuration file; Imports all desired modules.
# Modules in categories are split in their own, well, categories.
# Feel free to refer to `README.md`.

{ config, ... }: { imports = [

	./Android.nix
	./Audio.nix
#	./Bluetooth.nix
	./Boot.nix
	./Kernel.nix
	./Locale.nix
	./Monitors.nix
	./Networking.nix
	./Nix-settings.nix
	./Packaging.nix
	./Polkit.nix
	./Power.nix
	./Printing.nix
	./SSH.nix
	./Temporary.nix
	./Time.nix

#	./GPU/NVIDIA.nix
	./GPU/Shared.nix

	./hardware-configuration.nix
#	./Hardware-overrides.nix

	./Hyprland/Configuration.nix
	./Hyprland/Dunst.nix
	./Hyprland/Utilities.nix
	./Hyprland/Waybar.nix

	./Input/Fcitx5.nix
	./Input/Keyboard-layout.nix
#	./Input/OpenTabletDriver.nix
	./Input/Power-button.nix
	./Input/Utilities.nix
#	./Input/ZSA.nix

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

	./Storage/File-management.nix
	./Storage/File-utilities.nix
	./Storage/Filesystem-services.nix
	./Storage/Filesystem-settings.nix
	./Storage/Filesystem-support.nix
	./Storage/Optical-media.nix
#	./Storage/Storage-mounts.nix

	./Theming/Fonts.nix
	./Theming/Terminal-colors.nix
	./Theming/Program-themes.nix
	./Theming/Icon-themes.nix
	./Theming/Settings.nix

	./User/Home-manager.nix
	./User/Name.nix
	./User/Settings.nix
	./User/Shell.nix

#	./Virtualisation/Guest/HyperV.nix
#	./Virtualisation/Guest/QEMU-KVM.nix
#	./Virtualisation/Guest/VirtualBox.nix
#	./Virtualisation/Guest/VMWare.nix
#	./Virtualisation/Guest/XE.nix

#	./Virtualisation/Host/Docker.nix
#	./Virtualisation/Host/Virt-manager.nix
#	./Virtualisation/Host/Virtualbox.nix
#	./Virtualisation/Host/Waydroid.nix

#	./XFCE/Panel.nix
#	./XFCE/XFCE.nix

]; }
