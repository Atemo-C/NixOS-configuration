# Timeout in seconds until the first entry in the bootloader is activated.
{ config, ... }: { boot.loader.timeout = 3; }
