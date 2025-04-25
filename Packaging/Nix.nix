# Whether to allow installation of unfree packages.
{ config, ... }: { nixpkgs.config.allowUnfree = true; }
