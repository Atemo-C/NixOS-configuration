# Enabling OpenCL for compatible Intel GPUs.
{ config, pkgs, ... }: { hardware.graphics.extraPackages = [ pkgs.intel-compute-runtime ]; }
