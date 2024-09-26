# Documentation:
#───────────────
# • https://wiki.nixos.org/wiki/Waydroid
#
# Used NixOS options:
#────────────────────
# • https://search.nixos.org/options?channel=24.05&show=virtualisation.waydroid.enable

# Whether to enable Waydroid.
{ config, ... }: { virtualisation.waydroid.enable = true; }
