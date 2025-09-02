{ pkgs, ... }: { environment.systemPackages = with pkgs; [
	bat        # A `cat`(1) clone with syntax highlighting and Git integration.
	bc         # GNU software calculator.
	calcurse   # A calendar and scheduling application for the command line.
	dash       # A POSIX-compliant implementation of `/bin/sh` that aims to be as small as possible.
	gh         # GitHub CLI tool.
	git        # Distributed version control system.
	jq         # Lightweight and flexible command-line JSON processor.
	parallel   # Shell tool for executing jobs in parallel.
	shellcheck # Shell script analysis tool.
	tlrc       # Simplified and community-driven man pages, written in Rust.
	wget       # Tool for retrieving files using HTTP, HTTPS, and FTP.
]; }