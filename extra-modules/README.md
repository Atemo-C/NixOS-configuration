# Custom modules directory
This directory contains custom NixOS modules, used for various things throughout the system.
Notably, it contains:
- The **`user.nix`** module, where the shortcut for the user name and description are created (configurable in the `user/settings.nix` module);
- Custom **`programs.`** modules with added functionality and configurations;
- External modules such as **Home Manager**;
- Pull requests not yet merged in **nixpkgs**.