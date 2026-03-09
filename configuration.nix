# If you have not already, please read this configuration's README.
#──────────────────────────────────────────────────────────────────
#
# This module imports all other relevant modules used by the system.
# You can choose to select/unselect one simply by uncommenting/commenting it.
# Some modules may import their own submodules, outside of here.

{ ... }: { imports = [
	# The Niri Wayland compositor, and its accompanying utilities.
	./niri.nix

	# Custom modules used throughout the system. Other modules may rely on them;
	# As such, it is recommended to simply leave them be.
	./custom-modules/atemo_cajaku/programs/niri.nix
]; }