let
	# Fetch nixpkgs.
	pkgs = import <nixpkgs> {};

	# Fetch nix-flatpak.
	nix-flatpak = pkgs.fetchFromGitHub {
		owner = "gmodena";
		repo = "nix-flatpak";
		rev = "latest";
		hash = "sha256-7ZCulYUD9RmJIDULTRkGLSW1faMpDlPKcbWJLYHoXcs=";
	};

# Import nix-flatpak's NixOS module in the configuration.
in { imports = [ "${nix-flatpak}/modules/nixos.nix" ]; }

