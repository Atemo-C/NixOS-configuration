{ ... }: { imports = [
#	./computers/libvirt/hardware-configuration.nix
#	./computers/libvirt/settings.nix
	./computers/r7-pc/hardware-configuration.nix
	./computers/r7-pc/settings.nix

	./extra-modules/config/gpu-check.nix

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

	./virtualisation/virt-manager.nix
	./virtualisation/waydroid.nix
]; }
