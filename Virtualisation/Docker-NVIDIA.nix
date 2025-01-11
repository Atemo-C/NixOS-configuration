# Whether to enable CDI (for rootless Docker on NVIDIA).
{ config, ... }: { virtualisation.docker.rootless.daemon.settings.features.cdi = true; }
