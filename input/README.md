# 📁 Input directory
This directory contains modules to support and configure various input devices. \
Notably, it currently:
- Configures libinput;
- Sets the keyboard repeat rate and delay;
- Makes sure the desired keyboard layout is applied throughout the system;
- Enables the use of the OpenTabletDriver daemon instead of built-in drivers;
- Adds support for ZSA keyboards (I use the Moonlander Mark I);
- Installs various other input-related utilities.

The keyboard layout configuration is to be defined in your device's **`settings.nix`** module. If you use a fully custom keyboard layout, you may feel free to add the relevant options yourself.
