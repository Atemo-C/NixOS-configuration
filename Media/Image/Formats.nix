{ config, pkgs, ... }: {

	environment.systemPackages = with pkgs; [
		# JPEG XL support.
		libjxl

		# DICOM standard support.
		dcmtk

		# WEBP support.
		libwebp
	];

}
