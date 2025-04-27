# Override the Linux kernel used by NixOS.
{ config, pkgs, ... }: { boot.kernelPackages = pkgs.linuxPackages_zen; }
