# Extra conifg options for systemd-logind.
# Here, used to ignore the press of the power button, allowing it to be mapped to something else.
{ config, ... }: { services.logind.extraConfig = ''HandlePowerKey=ignore''; }
