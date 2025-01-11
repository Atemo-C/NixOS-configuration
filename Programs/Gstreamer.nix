# Open source multimedia framework.
{ pkgs, ... }: { environment.systemPackages = [

	pkgs.gst_all_1.gst-editing-services
	pkgs.gst_all_1.gst-libav
	pkgs.gst_all_1.gst-plugins-bad
	pkgs.gst_all_1.gst-plugins-base
	pkgs.gst_all_1.gst-plugins-good
	pkgs.gst_all_1.gst-plugins-rs
	pkgs.gst_all_1.gst-plugins-ugly
	pkgs.gst_all_1.gst-plugins-viperfx
	pkgs.gst_all_1.gst-vaapi
	pkgs.gst_all_1.gstreamer

]; }
