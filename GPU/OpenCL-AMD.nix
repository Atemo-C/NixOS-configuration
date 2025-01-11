# Enabling OpenCL for compatible AMD GPUs.
{ config, pkgs, ... }: { hardware.graphics.extraPackages = [ pkgs.rocmPackages.clr.icd ]; }
