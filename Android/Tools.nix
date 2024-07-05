{ pkgs, ... }: {

	environment.systemPackages = with pkgs; [
		# Display and control Android devices over USB or TCP/IP.
		scrcpy

		# Share an Ethernet connection over USB.
		gnirehtet

		# Implementation of Microsoft's Media Transfer Protocol.
		libmtp
	];

}
