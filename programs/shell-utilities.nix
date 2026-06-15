{ pkgs, ... }: {
	environment.systemPackages = with pkgs; [
		# A calendar and scheduling application for the command-line.
		calcurse

		# A POSIX-compliant implementation of `/bin/sh` that aims to be as small as possible.
		dash

		# GitHub CLI tool.
		gh

		# Lightweight and flexible command-line JSON processor.
		jq

		# Official formatter for Nix code.
		nixfmt

		# Shell tool for executing jobs in parallel.
		parallel

		# Readline wrapper for console programs.
		rlwrap

		# Shell script analysis tool.
		shellcheck

		# Simplified and community-driven man pages.
		tlrc

		# Tool for retrieving files using HTTP, HTTPS, and FTP.
		wget
	];

	programs = {
		# Whether to enable bat, a `cat (1)` clone with syntax highlighting and Git integration.
		bat.enable = true;

		# Whether interactive shells should show which Nix package (if any) provides the missing command.
		command-not-found.enable = true;

		# Whether to enable git, a distributed version control system.
		git.enable = true;
	};
}