{ ... }: {
	security = {
		# Whether to enable sudo.
		sudo.enable = false;

		run0 = {
			# Whether to enable `run0`.
			enable = true;

			# Whether to alias `sudo` to `run0`.
			enableSudoAlias = true;
		};
	};

	# Temporarily allow insecure packages to be installed.
	nixpkgs.config.permittedInsecurePackages = [
		"librewolf-151.0.2-1"
		"librewolf-unwrapped-151.0.2-1"
	];
}