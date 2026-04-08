# Input directory
This directory contains modules to configure input devices and install input utilities.

## [`input-settings.nix`](./input-settings.nix)
This module is imported in [`configuration.nix`](../configuration.nix).

### [`console.useXkbConfig`](./input-settings.nix#L2)
Ensure the TTY uses the keyboard layout configuration from your device's `settings.nix` module.

##

### [`environment.variables.XKB_DEFAULT_<>`](./input-settings.nix#L4)
Apply the keyboard layout configuration from your device's `settings.nix` module through the use of environment variables. Certain programs require this to be set to avoid having to manually configure the keyboard layout settings in them.

##

### [`services.kmscon.useXkbConfig`](./input-settings.nix#L12)
Ensure Kmscon uses the keyboard layout configuration from your device's `settings.nix` module.

##

### [`services.libinput.mouse.accelProfile`](./input-settings.nix#L15)
Set the mouse's acceleration profile. I prefer it flat.

##

### [`services.libinput.touchpad.tapping`](./input-settings.nix#L16)
Enable tap-to-click on touchpads.

##

### [`services.xserver.autoRepeatDelay`](./input-settings.nix#L20)
Delay in milliseconds before a held-down key repeats.

##

### [`services.xserver.autoRepeatInterval`](./input-settings.nix#L21)
Rate in characters per second to repeat when holding down a key.

---

## [`opentabletdriver.nix`](./opentabletdriver.nix)
• [OpenTabletDriver's GitHub repository](https://github.com/OpenTabletDriver/OpenTabletDriver) \
This module is to be imported in your device's `settings.nix` module, if you want it.

### [`hardware.opentabletdriver.enable`](./opentabletdriver.nix#L1)
Enable OpenTabletDriver udev rules, user service, and blacklist conflicting kernel modules.

---

## [`utilities.nix`](./utilities.nix)
This module is imported in [`configuration.nix`](../configuration.nix).

### [`programs.evhz.enable`](./utilities.nix#L2)
• [evhz's sourcehut's repository](https://git.sr.ht/~iank/evhz) \
**`[C]`** Show mouse refresh rate under Linux + evdev.

This option is created by the [`evhz.nix`](../extra-modules/atemo_cajaku/programs/evhz.nix#L2) programs module.

##

### [`programs.evsieve.enable`](./utilities.nix#L3)
• [evsieve's GitHub repository](https://github.com/KarsMulder/evsieve) \
**`[C]`** Utility for mapping events from Linux event devices.

This option is created by the [`evsieve.nix`](../extra-modules/atemo_cajaku/programs/evsieve.nix#L2) programs module.

##

### [`programs.jstest-gtk.enable`](./utilities.nix#L4)
• [jstest-gtk's GitHub repository](https://github.com/Grumbel/jstest-gtk) \
**`[C]`** Simple joystick and gamepad tester.

This option is created by the [`jstest-gtk.nix`](../extra-modules/atemo_cajaku/programs/jstest-gtk.nix#L2) programs module.

##

### [`programs.typioca.enable`](./utilities.nix#L5)
• [typioca's GitHub repository](https://github.com/bloznelis/typioca) \
**`[C]`** Cozy typing speed tester in the console.

This option is created by the [`typioca.nix`](../extra-modules/atemo_cajaku/programs/typioca.nix#L2) programs module.

##

### [`programs.usbutils.enable`](./utilities.nix#L6)
• [The Linux USB website](http://www.linux-usb.org/) \
**`[C]`** Utility for mapping events from Linux event devices.

This option is created by the [`usbutils.nix`](../extra-modules/atemo_cajaku/programs/usbutils.nix#L2) programs module.

##

### [`programs.ydotool.enable`](./utilities.nix#L7)
• [ydotool's GitHub repository](https://github.com/ReimuNotMoe/ydotool) \
Enable the ydotool system service and `ydotool` for members of `programs.ydotool.group`.

This option is built into NixOS, but here also automatically adds the user to the `ydotool` group thanks to the [`ydotool.nix`](../extra-modules/atemo_cajaku/programs/ydotool.nix#L2) module.

---

## [`zsa.nix`](./zsa.nix)
• [ZSA's website](https://www.zsa.io) \
This module is to be imported in your device's `settings.nix` module, if you want it.

### [`programs.zsa.keymapp.enable` ](./zsa.nix#L2)
Graphical utility to interact with and flash ZSA keyboards.

This option is created by the [`zsa.nix`](../extra-modules/atemo_cajaku/programs/zsa.nix#L3) programs module.

##

### [`programs.zsa.wally-cli.enable` ](./zsa.nix#L3)
CLI utility to flash ZSA keyboards.

This option is created by the [`zsa.nix`](../extra-modules/atemo_cajaku/programs/zsa.nix#L4) programs module.