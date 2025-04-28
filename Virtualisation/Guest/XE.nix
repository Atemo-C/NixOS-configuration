# Enable the XenServer guest utilities daemon.
{ config, ... }: { services.xe-guest-utilities.enable = true; }
