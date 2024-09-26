# Used NixOS packages:
#─────────────────────
# • [brightnessctl]
#   https://github.com/Hummer12007/brightnessctl
#
# • [pmutils]
#   https://pm-utils.freedesktop.org/wiki/

{ pkgs, ... }: { environment.systemPackages = [

	# This program allows you read and control device brightness.
	pkgs.brightnessctl

	# A small collection of scripts that handle suspend and resume on behalf of HAL.
	# Useful for systems where systemctl suspend doesn't work properly, such as the ThinkPad L510.
	pkgs.pmutils

]; }
