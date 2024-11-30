# Documentation:
#───────────────
# • https://wiki.archlinux.org/title/Power_management#ACPI_events
#
# Used NixOS option:
#───────────────────
# • https://search.nixos.org/options?channel=24.11&show=services.logind.extraConfig

# Extra config options for systemd-logind. Here, used to ignore the press of the power button.
{ conifg, ... }: { services.logind.extraConfig = ''HandlePowerKey=ignore''; }
