# Enable the VirtualBox service and other guest additions.
{ config, ... }: { virtualisation.virtualbox.guest.enable = true; }
