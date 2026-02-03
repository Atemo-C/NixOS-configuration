{ ... }: { programs = {
	# GNU software calculator.
	bc.install = true;

	# A calendar and scheduling application for the command line.
	calcurse.install = true;

	# A POSIX-compliant implementation of `/bin/sh` that aims to be as small as possible.
	dash.install = true;

	# GitHub CLI tool.
	gh.install = true;

	# Lightweight and flexible command-line JSON processor.
	jq.install = true;

	# Whether to enable parallel, a hell toll for executing jobs in parallel.
	parallel.enable = true;

	# Whether to enable shellcheck, a hell script analysis tool.
	shellchek.enable = true;

	# Simplified and community-driven man pages, written in Rust.
	tlrc.install = true;

	# Tool for retrieving files using HTTP, HTTPS, and FTP.
	wget.install = true;

	# Whether to enable bat, a `cat (1)` clone with syntax highlighting and Git integration.
	bat.enable = true;

	# Whether interactive shells should show which Nix package (if any) provides a missing command.
	command-not-found.enable = true;

	# Whether to enable git, a distributed version control system.
	git.enable = true;
}; }