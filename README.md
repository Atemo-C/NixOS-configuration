# EXPERIMENTAL BRANCH!
# ASSUME THAT EVERYTHING HERE IS BROKEN AND UNFINSHED!

![Screenshot of my current desktop](https://github.com/Atemo-C/NixOS-configuration/blob/main/Desktop.webp)
Wallpaper created by Dzaka.
=> https://www.dzaka.fr/galerie/frontpage

# General information
This NixOS configuration is almost exactly what I use on my own systems.
It is a successor to my old NixOS configuration, which is now archived.
=> https://github.com/Atemo-C/OLD-NixOS-Configuration

It is a single-user setup, using the Niri Wayland compositor as the Wayland compositor.
=> https://github.com/YaLTeR/niri

It is based entirely on NixOS unstable, and relies partially on Home Manager (but does not use Flakes).
=> https://github.com/nix-community/home-manager

It uses lots of custom Nix modules, most simply replacing package lists by `programs.` options whenever possible. This is mostly a stylistic choice, but some modules do add some functionality and pre-configurations.
=> https://github.com/Atemo-C/NixOS-configuration/blob/main/nix-modules/

# Made for a specific installation
This NixOS configuration is not made to be something anyone can just use on their own systems; Not without tweaks, at least. I have a pretty consistent way of setting up most of my computers when I install NixOS.
Below are the steps I take to install NixOS on my devices.

## Downloading NixOS
Since I use NixOS unstable, I download the unstable ISO image too. Graphical or not, it matters not for me, but if you need to use a graphical environment during the installation, go with the graphical one.
=> https://channels.nixos.org/nixos-unstable/latest-nixos-graphical-x86_64-linux.iso
=> https://channels.nixos.org/nixos-unstable/latest-nixos-minimal-x86_64-linux.iso

## Creating a bootable NixOS medium