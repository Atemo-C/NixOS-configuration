# Which version of the Linux kernel to use.
{ config, pkgs, ... }: { boot.kernelPackages = pkgs.unstable.linuxPackages_zen; }
