{ pkgs, ... }: {
	environment.systemPackages = with pkgs; [
		# A `cat`(1) clone with syntax highlighting and Git integration.
		bat

		# GNU software calculator.
		bc

		# A calendar and scheduling application for the command line.
		calcurse

		# A POSIX-compliant implementation of `/bin/sh` that aims to be as small as possible.
		dash

		# Distributed version control system & GitHub CLI tool.
		git
		gh

		# Lightweight and flexible command-line JSON processor.
		jq

		# Shell tool for executing jobs in parallel.
		parallel

		# Shell script analysis tool.
		shellcheck

		# Simplified and community-driven man pages, written in Rust.
		tlrc

		# Tool for retrieving files using HTTP, HTTPS, and FTP.
		wget
	];
}