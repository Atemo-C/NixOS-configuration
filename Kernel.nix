# Documentation:
#───────────────
# • https://wiki.nixos.org/wiki/Linux_kernel
#
# Used NixOS options:
#────────────────────
# • https://search.nixos.org/options?channel=24.05&show=boot.kernelPackages

# Which version of the Linux Kernel to be used by NixOS.
{ config, pkgs, ... }: { boot.kernelPackages = pkgs.unstable.linuxPackages_zen; }
