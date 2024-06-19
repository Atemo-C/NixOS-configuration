{ config, pkgs, ... }: {

	# Open source multimedia framework.
	environment.systemPackages = with pkgs.gst_all_1; [
		gst-editing-services
		gst-libav
		gst-plugins-bad
		gst-blugins-base
		gst-plugins-good
		gst-plugins-rs
		gst-plugins-ugly
		gst-plugins-viperfx
		gst-vaapi
		gstreamer
	];

}

