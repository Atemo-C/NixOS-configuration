{ ... }: { imports = [
	# This is the device currently in use.
	# Change it to the one desired.
	./computers/r7-pc/hardware-configuration.nix
	./computers/r7-pc/settings.nix

	# Below is a list of modules that apply across all systems.
	./extra-modules/config/gpu-check.nix
	./extra-modules/config/theming.nix

	./desktop/niri.nix

	./input/keyboard-layout.nix
	./input/utilities.nix

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

	./storage/file-management.nix

	./system/zram.nix
	./system/boot.nix
	./system/security.nix
	./system/power.nix
	./system/networking.nix
	./system/nix-settings.nix
	./system/locale.nix
	./system/audio.nix
	./system/ssh.nix
	./system/printing.nix

	./theming/fonts.nix
	./theming/programs.nix
	./theming/terminal-colors.nix

	./user/settings.nix
	./user/shell.nix

/*
	Below is a list of modules that do not apply across all systems by default.
	They must be imported in your device's `settings.nix` module,
	if you want them.

	# Proprietary NVIDIA GPU support (1650 and higher).
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
