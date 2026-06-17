{ pkgs, ... }: { environment.systemPackages = with pkgs; [
	# CLI Gemini client.
	amfora

	# Matrix client.
	element-desktop

	# Graphical Gemini client.
	lagrange

	# Small 'net top' tool, grouping bandwidth by process.
	nethogs

	# BitTorrent client.
	qbittorrent

	# Qt Tox client.
	qtox

	# Adobe Flash Player emulator.
	ruffle

	# Desktop application for SimpleX Chat.
	simplex-chat-desktop

	# Graphical librespeed client.
	speedtest

	# Anonymizing overlay network.
	tor

	# Privacy-focused, Firefox-based browser routing traffic through the Tor network.
	tor-browser

	# Fork of Firefox, focused on privacy, security and freedom
	librewolf
]; }