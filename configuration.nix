# This module must be imported in your device's `settings.nix` module.
# `/etc/nixos/computers/<your-computer>/settings.nix`.
# Otherwise, no system!

{ ... }: { imports = [
	# Below is a list of modules that apply across all systems.

	# This module allows defining which GPU your system is using.
	# `hardware.activeGpu` should be set in your device's `gpu.nix` module,
	# at `/etc/nixos/computers/<your-computer/gpu.nix`, and the `gpu.nix` module
	# should be imported in your device's `settings.nix` module.
	./extra-modules/config/gpu-check.nix

	# This module allows setting global theming options across the system.
	./extra-modules/config/theming.nix

	# This module configures a fully working Niri + Noctalia desktop.
	./desktop/niri.nix

	# This module applies your keyboard layout settings globally.
	# Your keyboard layout should be set in your device's `input.nix` module,
	# at `/etc/nixos/computers/<your-computer>/input.nix`, and the `input.nix` module
	# should be imported in your device's `settings.nix` module.
	./input/keyboard-layout.nix

	# Various input utilities.
	./input/utilities.nix

	# Programs to install across the system, arranged by categories.
	./programs/3d.nix
	./programs/accessories.nix
	./programs/android.nix
	./programs/gaming.nix
	./programs/internet.nix
	./programs/multimedia.nix
	./programs/office.nix
	./programs/shell-utilities.nix
	./programs/system-info.nix
	./programs/terminal-emulator.nix
	./programs/text.nix

	# Non-device-specific file management software and tools.
	./storage/file-management.nix

	# ZRAM swap configuration.
	./system/zram.nix

	# Boot configuration.
	./system/boot.nix

	# Security configuration.
	./system/security.nix

	# Power configuration.
	./system/power.nix

	# Networking configuration.
	./system/networking.nix

	# Various Nix-related settings.
	./system/nix-settings.nix

	# System locale/language configuration.
	./system/locale.nix

	# Audio configuration.
	./system/audio.nix

	# OpenSSH configuration.
	./system/ssh.nix

	# Printing configuration.
	# Currently, this is global, but it may be split in different
	# modules (generic printing support, scanning, drivers, etc),
	# which would then have to be imported in your device's `settings.nix` module.
	#
	# This may be done at a later date.
	./system/printing.nix

	# Font configuration.
	./theming/fonts.nix

	# Graphical program theming.
	./theming/programs.nix

	# Colors in the terminal emulator of choice and in the TTY.
	./theming/terminal-colors.nix

	# User settings.
	./user/settings.nix

	# User's shell settings.
	./user/shell.nix

/*
	Below is a list of modules that do not apply across all systems by default.
	They must be imported in your device's `settings.nix` module,
	or other relevant computer modules, if you want them.

	# Proprietary NVIDIA GPU support (1630 and higher).
	# This one should be in your device's `gpu.nix` module.
	./extra-modules/nvidia.nix

	# Replace standard suspend commands with pmutils commands.
	# This can be useful on older, buggier firmwares (e.g. ThinkPad L510).
	./programs/pmutils.nix

	# Convert the MiDiPLUS SmartPAD into a full macro pad.
	# The hardware identifiers must be changed to your own's.
	./scripts/midiplus-smartpad-macropad.nix

	# Use the OpenTabletDriver to manage graphical tablets.
	./input/opentabletdriver.nix

	# Full support for ZSA keyboards.
	./input/zsa.nix

	# Bluetooth support.
	./system/bluetooth.nix

	# Virt-Manager support (host).
	./virtualisation/virt-manager.nix

	# Waydroid support (host).
	./virtualisation/waydroid.nix

	# Libvirt additions (guest).
	./virtualisation/guest/libvirt.nix
*/
]; }
