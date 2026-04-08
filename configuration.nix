# If you have not already, please read this configuration's README file.
# This module imports all other relevant modules used by the system,
# with the exception of device-specific modules.
# You can choose to select or unselect them by uncommenting or commenting them.
# Some modules may import their own submodules; They are thus not present here.
#
# Ideally, none of the extra-modules modules should be commented out.
{ ... }: { imports = [
	./desktop/niri.nix

	./input/input-settings.nix
	./input/utilities.nix

	./uncategorized/boot.nix
	./uncategorized/power.nix
	./uncategorized/zram.nix

	./extra-modules/atemo_cajaku/config/user.nix
	./extra-modules/atemo_cajaku/programs/acpi.nix
	./extra-modules/atemo_cajaku/programs/brightnessctl.nix
	./extra-modules/atemo_cajaku/programs/ddcutil.nix
	./extra-modules/atemo_cajaku/programs/efibootmgr.nix
	./extra-modules/atemo_cajaku/programs/evhz.nix
	./extra-modules/atemo_cajaku/programs/evsieve.nix
	./extra-modules/atemo_cajaku/programs/jstest-gtk.nix
	./extra-modules/atemo_cajaku/programs/lz4.nix
	./extra-modules/atemo_cajaku/programs/networkmanager.nix
	./extra-modules/atemo_cajaku/programs/niri.nix
	./extra-modules/atemo_cajaku/programs/niri-screenshot.nix
	./extra-modules/atemo_cajaku/programs/noctalia-shell.nix
	./extra-modules/atemo_cajaku/programs/typioca.nix
	./extra-modules/atemo_cajaku/programs/usbutils.nix
	./extra-modules/atemo_cajaku/programs/virt-manager.nix
	./extra-modules/atemo_cajaku/programs/ydotool.nix
	./extra-modules/atemo_cajaku/programs/zsa.nix
]; }