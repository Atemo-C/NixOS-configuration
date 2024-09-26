# Used NixOS packages:
#─────────────────────
# • [desmume]
#   https://www.github.com/TASVideos/desmume/
#
# • [pcsx2]
#   https://pcsx2.net/
#
# • [rpcs3]
#   https://rpcs3.net/

{ pkgs, ... }: { environment.systemPackages = [

	# An open-source Nintendo DS emulator.
	pkgs.unstable.desmume

	# Playstation 2 emulator.
	pkgs.unstable.pcsx2

	# PS3 emulator/debugger.
	pkgs.unstable.rpcs3

]; }
