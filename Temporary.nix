# Temporary module to """fix""" some stuff. Ugh.

{ config, pkgs, ... }: { nixpkgs.config.permittedInsecurePackages = [ "dotnet-runtime-6.0.36" ]; }
