# Whether to enable OpenTabletDriver udev rules, user service,
# and blacklist kernel modules known to conflict with OpenTabletDriver.
{ ... }: { hardware.opentabletdriver.enable = true; }