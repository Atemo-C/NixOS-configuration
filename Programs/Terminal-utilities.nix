{ pkgs, ... }: { environment.systemPackages = [

	# A cat(1) clone with syntax highlighting and Git integration.
	pkgs.bat

	# A calendar and scheduling application for the command line.
	pkgs.calcurse

	# A POSIX-compliant implementation of /bin/sh that aims to be as small as possible.
	pkgs.dash

	# Tool for retrieving files using HTTP, HTTPS, and FTP.
	pkgs.wget

	# Distributed version control system & GitHub CLI tool.
	pkgs.git pkgs.gh

	# Simplified and community-driven man pages, written in Rust.
	pkgs.tlrc

	# Shell tool for executing jobs in parallel.
	pkgs.parallel

]; }
