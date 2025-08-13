{ ... }: { imports = [

	./desktop/dunst.nix
	./desktop/fuzzel.nix
	./desktop/niri.nix
	./desktop/swaylock.nix
	./desktop/utilities.nix
	./desktop/waybar.nix

	#./gpu/nvidia.nix
	./gpu/shared.nix

	#./hardware/devices/hp-250-g6.nix
	#./hardware/devices/r5-pc.nix
	#./hardware/devices/thinkpad-l510.nix

	#./hardware/generated/hp-250-g6.nix
	#./hardware/generated/r5-pc.nix

	./input/keyboard-layout.nix
	./input/opentabletdriver.nix
	./input/utilities.nix
	./input/zsa.nix

	./programs/3d.nix
	./programs/accessories.nix
	./programs/gaming.nix
	./programs/internet.nix
	./programs/multimedia.nix
	./programs/office.nix
	./programs/shell-utilities.nix
	./programs/system-info.nix
	./programs/terminal-emulator.nix
	./programs/text.nix

	./scripts/crosshair/crosshair.nix

	./storage/file-management.nix
	./storage/file-utilities.nix
	./storage/filesystems.nix
	./storage/mounts.nix

	./theming/fonts.nix
	./theming/icons.nix
	./theming/programs.nix
	./theming/terminal-colors.nix

	./uncategorized/android.nix
	./uncategorized/audio.nix
	./uncategorized/bluetooth.nix
	./uncategorized/boot.nix
	./uncategorized/locale.nix
	./uncategorized/networking.nix
	./uncategorized/nix-settings.nix
	./uncategorized/packaging.nix
	./uncategorized/power.nix
	./uncategorized/printing.nix
	./uncategorized/ssh.nix
	./uncategorized/temporary.nix

	./user/home-manager.nix
	./user/name.nix
	./user/settings.nix
	./user/shell.nix

	#./virtualisation/guest/hyperv.nix
	#./virtualisation/guest/qemu.nix
	#./virtualisation/guest/virtualbox.nix
	#./virtualisation/guest/vmware-xe.nix

	#./virtualisation/host/docker.nix
	#./virtualisation/host/virt-manager.nix
	#./virtualisation/host/virtualbox.nix
	#./virtualisation/host/waydroid.nix
]; }
