# Temporary module to """fix""" some stuff. Ugh.

{ config, pkgs, ... }: { nixpkgs.config.permittedInsecurePackages = [
	"dotnet-runtime-6.0.36"
	"dotnet-runtime-wrapped-6.0.36"
	"dotnet-sdk-wrapped-6.0.428"
	"dotnet-sdk-6.0.428"
]; }
