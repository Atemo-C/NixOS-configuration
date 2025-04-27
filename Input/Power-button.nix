# Configure systemd-logind to ignore power button actions, letting the user customize them instead.
{ config, ... }: { services.logind.extraConfig = ''HandlePowerKey=ignore''; }
