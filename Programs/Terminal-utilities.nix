{ pkgs, ... }: { environment.systemPackages = with pkgs; [

	# A cat(1) clone with syntax highlighting and Git integration.
	bat

	# A calendar and scheduling application for the command line.
	calcurse

	# A POSIX-compliant implementation of /bin/sh that aims to be as small as possible.
	dash

	# Tool for retrieving files using HTTP, HTTPS, and FTP.
	wget

	# Distributed version control system & GitHub CLI tool.
	git gh

	# Simplified and community-driven man pages, written in Rust.
	tlrc

	# Shell tool for executing jobs in parallel.
	parallel

]; }
