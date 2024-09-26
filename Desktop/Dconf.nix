# Used NixOS options:
#────────────────────
# • https://search.nixos.org/options?channel=24.05&show=programs.dconf.enable

# Whether to enable dconf.
# Needed by some programs.
{ config, ... }: { programs.dconf.enable = true; }
