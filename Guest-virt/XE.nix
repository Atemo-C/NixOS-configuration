# Whether to enable the XenServer guest utilities daemon.
{ config, ... }: { services.xe-guest-utilities.enable = true; }
