# Used NixOS options:
#────────────────────
# • https://search.nixos.org/options?channel=24.11&show=programs.dconf.enable

# Whether to enable dconf.
# Needed by some programs.
{ config, ... }: { programs.dconf.enable = true; }
