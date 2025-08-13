{ config, lib, pkgs, ... }: {
	environment = {
		systemPackages = with pkgs; [
			# CLI Gemini client.
			amfora

			# Anonymizing ovelay network.
			tor
		] ++ lib.optionals config.programs.niri.enable (with pkgs; [
			# Matrix client.
			element-desktop

			# Graphical Gemini client.
			lagrange

			# Fork of the Firefox web browser, focused on privacy and security.
			librewolf

			# BitTorrent client.
			qbittorrent

			# Open-source Discord-like chat platform.
			revolt-desktop

			# Cross platform Adobe Flash Player emulator.
			# Note: Not necessarily an "internet" app, but come on, Flash games!
			ruffle

			# Graphical librespeed client.
			speedtest

			# Privaly-focused, Firefox-based browser routing traffic through the Tor network.
			tor-browser

			# Alternate Discord client with Vencord built-in.
			vesktop
		]);

		# Set the default web browser.
		variables = { BROWSER = "librewolf"; };
	};
}