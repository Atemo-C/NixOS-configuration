# Settings for connected monitors during the boot process.
{ config, ... }: { boot.kernelParams = [

	# [Main] Center DisplayPort monitor.
	"video=DP-1:1920x1080@120"

	# [Secondary] Left HDMI-to-VGA monitor.
	"video=HDMI-A-1:1600x900@60"

]; }
