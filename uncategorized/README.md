# Uncategorized directory
This directory contains modules that do not fit in any particular category. This does not make them any less important, as this directory contains settings such as the bootloader, NVIDIA GPU drivers, ZRAM swap compression, and much more.

## [`audio.nix`](./audio.nix)
This module is imported in [`configuration.nix`](../configuration.nix).

### [`services.pipewire.enable`](./audio.nix#L3)
• [PipeWire's website](https://pipewire.org/)

Enable the PipeWire multimedia framework. \
Support for other audio servers emulation is available and enabled by default in this configuration.

##

### [`services.playerctld.enable`](./audio.nix#L13)
• [playerctld's GitHub repository](https://github.com/acrisci/playerctl)

Enable the daemon for easy multimedia control accross environments.

##

### [`security.rtkit.enable`](./audio.nix#L14)
• [rtkit's freedesktop.org page](https://gitlab.freedesktop.org/pipewire/rtkit)
Enable the Realtimekit service to allow programs like PipeWire to acquire realtime priority.

##

### [`programs.alsa-utils.enable`](./audio.nix#L17)
• [ALSA's website](http://www.alsa-project.org/)

**`[C]`** Various utilities for ALSA.

This option is created by the [`alsa-utils.nix`](../extra-modules/atemo_cajaku/programs/alsa-utils.nix) programs module.

##

### [`programs.audacious.enable`](./audio.nix#L18)
• [Audacious' website](https://audacious-media-player.org/)

**`[C]`** Lightweight and versatile audio player.

This option is created by the [`audacious.nix`](../extra-modules/atemo_cajaku/programs/audacious.nix) programs module.

##

### [`programs.audacity.enable`](./audio.nix#L19)
• [Audacity's website](https://www.audacityteam.org/)

**`[C]`** Sound editor with graphical UI.

This option is created by the [`audacity.nix`](../extra-modules/atemo_cajaku/programs/audacity.nix) programs module.

##

### [`programs.easytag.enable`](./audio.nix#L20)
• [EasyTag's GitLab repository](https://gitlab.gnome.org/GNOME/easytag)

**`[C]`** View and edit tags for various audio files.

This option is created by the [`easytag.nix`](../extra-modules/atemo_cajaku/programs/easytag.nix) programs module.

##

### [`programs.pwvucontrol.enable`](./audio.nix#L21)
• [pwvucontrol's GitHub repository](https://github.com/saivert/pwvucontrol)

**`[C]`** PipeWire volume control.

This option is created by the [`pwvucontrol.nix`](../extra-modules/atemo_cajaku/programs/pwvucontrol.nix) programs module.

##

### [`programs.qpwgraph.enable`](./audio.nix#L22)
• [qpwgraph's freedesktop.org page](https://gitlab.freedesktop.org/rncbc/qpwgraph)

**`[C]`** QT graph manager for PipeWire, similar to QjackCtl.

This option is created by the [`qpwgraph.nix`](../extra-modules/atemo_cajaku/programs/qpwgraph.nix) programs module.

##

### [`programs.soundfont.fluid.enable`](./audio.nix#L23)
• [Hammersound webpage](http://www.hammersound.net/)

**`[C]`** General MIDI-copmliant bank.

This option is created by the [`soundfont.nix`](../extra-modules/atemo_cajaku/programs/soundfont.nix) programs module. \
When a MIDI soundfont is enabled, the soundfont directories are automatically linked to "/run/current-system/sw/share/soundfonts/" for easier access.
##

### [`fish.shellAbbrs`](./audio.nix#L26)
FISH shell abbreviation for listening to various online audio streams with MPV.

---

## [`bluetooth.nix`](./bluetooth.nix)
This module is to be imported in your device's `settings.nix` module, if you want it.

### [`hardware.bluetooth.enable`](./bluetooth.nix#L2)
Enable Bluetooth support.

##

### [`services.blueman.enable`](./bluetooth.nix#L3)
Enable the Blueman Bluetooth service if Bluetooth support is enabled.

---

## [`boot.nix`](./nix)
This module is imported in [`configuration.nix`](../configuration.nix).

### [`boot.initrd.systemd.enable`](./boot.nix#L3)
Enable systemd in initrd. This allows better integration with Plymouth, LUKS encryption prompt, and more.

##

### [`boot.kernelPackages`](./boot.nix#L4)
Select the Linux Kernel version to use. See the following for more infromation:
• [NixOS Wiki - Available Linux Kernels](https://wiki.nixos.org/wiki/Linux_kernel#List_available_kernels)

##

### [`boot.kernelParams`](./boot.nix#L5)
Additional kernel parameters. Here, `preempt=full` is set to help with performance, audio crackling, and other issues in certain areas.

##

### [`boot.loader.limine.enable`](./boot.nix#L9)
• [Limine's website](https://limine-bootloader.org/)

Enable the Limine bootloader. \
If you are on a BIOS-only system, you need to manually set `boot.loader.limine.efiSupport = false;` and set `boot.loader.limine.biosDevice = "";` to the device where Limine is installed onto (e.g. `/dev/sda` or `/dev/disk/by-id/ata-SUPER_COOL_HDD-123`).

##

### [`boot.loader.limine.maxGenerations`](./boot.nix#L10)
Maximum number of latest generations to keep in the boot menu. \
Lowering this value may help prevent the boot partition from running out of space.

##

### [`boot.loader.timeout`](./boot.nix#L16)
Timeout in seconds until the first entry in the bootloader is activated. \
Use `null` if the menu should be displayed until the user manually activates an entry.

##

### [`boot.plymouth.enable`](./boot.nix#L17)
• [Plymouth's Wiki page on freedesktop.org](https://www.freedesktop.org/wiki/Software/Plymouth)

Enable the Plymouth boot splash screen.

##

### [`boot.plymouth.theme`](./boot.nix#L18)
Plymouth theme to use. \
Here, `deus_ex` is used.

• [Link to the deus_ex Plymouth theme from adi1090x's Plymouth themes](https://github.com/adi1090x/plymouth-themes/tree/master/pack_2/deus_ex)

##

### [`boot.plymouth.themePackages`](./boot.nix#L19)
Package providing the plymouth theme.

##

### [`services.kmscon.enable`](./boot.nix#L26)
• [Kmscon's Wiki page on freedesktop.org](https://www.freedesktop.org/wiki/Software/kmscon/)

Enable the Kmscon terminal emulator instead of autovt. \
As this currently has some issue, I set it to `false` in this configuration, but I hope this will change sooner than later. It is neat.

##

### [`services.kmscon.extraConfig`](./boot.nix#L27)
Extra configuration to add to Kmscon. \
Here, mouse support is enabled.
- Kmscon theming can be found in the [`/etc/nixos/theming/console.nix`](../theming/console.nix) module;
- Kmscon font configuration can be found in the [`/etc/nixos/theming/fonts.nix`](../theming/fonts.nix) module.

##

### [`programs.efibootmgr.enable`](./boot.nix#L30)
**`[C]`** Linux user-space application to modify the EFI boot manager. \
This is not installed if booting in a BIOS-only system.

This option is created by the [`efibootmgr.nix`](../extra-modules/atemo_cajaku/programs/efibootmgr.nix) programs module.

##

### [`config = lib.mkIf config.boot.plymouth.enable`](./boot.nix#L32)
Apply various boot options to make it "quieter", allowing Plymouth to be displayed more neatly. \
These options are not applied if Plymouth is disabled.

---

## [`locale.nix`](./locale.nix)
This module is imported in [`configuration.nix`](../configuration.nix).

### [`i18n.defaultLocale`](./locale.nix#L3)
Default language of the system.

##

### [`i18n.extraLocaleSettings`](./locale.nix#L5)
Additional locale settings other than the user interface language.

##

### [`time.timeZone`](./locale.nix#L19)
The time zone used when displaying times and dates. \
See https://wikipedia.org/wiki/List_of_tz_database_time_zones for this setting. \
If `null`, the time zone will default to UTC and can beset imperatively using `timedatectl`.

##

### [`time.hardwareClockInLocalTime`](./locale.nix#L20)
Keep the hardware clock in local time instead of UTC. \
This is mostly useful if dual-booting with a Windows-based operating system; Though, this setting can also be changed on Windows to fix the issue the other way around.

---

## [`networking.nix`](./networking.nix)
This module is imported in [`configuration.nix`](../configuration.nix).

### [networking.dhcpcd.wait](./networking.nix#L3)
Fork the dhcpcd device to the background to improve boot times.

##

### [networking.networkmanager.enable](./networking.nix#L4)
• [NetworkManager's website](https://networkmanager.dev/)

Enable NetworkManager for easy network management.

This option is built into NixOS, but additionally, the user is automatically added to the `networkmanager` group thanks to the [`networkmanager.nix`](../extra-modules/atemo_cajaku/programs/networkmanager.nix) programs module.

##

### [networking.stevenblack.enable](./networking.nix#L7)
Enable stevenblack hosts file blocking. \
It blocks domain names for advertising, tracking, and more.

##

### [networking.stevenblack.block](./networking.nix#L8)
Additional blocklist extensions to enable.

##

### [systemd.services.NetworkManager-wait-online.enable](./networking.nix#L12)
Disable NetworkManager's `wait-online` service to improve boot times. \
If something relies on networking as soon as possible during boot, you might want to set it to `true`.

---

## [`nix-settings.nix`](./nix-settings.nix)
This module is imported in [`configuration.nix`](../configuration.nix).

### [`nix.settings.auto-optimise-store`](./nix-settings.nix#L3)
Automatically detect files in the store that have identical contents, and replace them with hard links to a single copy; Saving disk space.

##

### [`nix.settings.download-buffer-size`](./nix-settings.nix#L4)
Increase the download buffer to avoid annoying warnings.

##

### [`nix.settings.experimental-features`](./nix-settings.nix#L5)
Enable the `nix-command` feature.

##

### [`programs.hydra-check.enable`](./nix-settings.nix#L8)
• [hydra-check's GitHub repository](https://github.com/nix-community/hydra-check)

Check hydra for the build status of a package.

This option is created by the [`hydra-check.nix`](../extra-modules/atemo_cajaku/programs/hydra-check.nix) programs module.

##

### [`security.sudo.enable`](./nix-settings.nix#L11)
Whether to enable `sudo`. I use `run0` instead, but if you do not, change it to `true`.

##

### [`security.run0.enableSudoAlias`](./nix-settings.nix#L12)
Enable aliasing `sudo` to `run0`, if `run0` is enabled and `sudo` is disabled.

##

### [`system.stateVersion`](./nix-settings.nix#L15)
Which version of NixOS was initially installed on the current system. \
There is no need to change it after installation, even when upgrading to a newer NixOS version. Only change it if you are fully reinstalling NixOS with a different version.

##

### [`systemd.tmpfiles.rules`](./nix-settings.nix#L16)
Give read and write access to `/etc/nixos/` to the `root` user and to users in the `wheel` group (which, in this configuration, includes the default user).

---

## [`nvidia.nix`](./nvidia.nix)
• [NVIDIA's UNIX page](https://www.nvidia.com/object/unix.html)

This module configures both the proprietary and fully open-source drivers for NVIDIA GPUs of the Turing generation and later. If you have this module imported in your configuration, the system will by default boot with the proprietary drivers, with an option to boot with the fully open-source driver stack. The later can also be used to boot if you remove your NVIDIA GPU; It should not cause conflicts.

This module is to be imported in your device's `settings.nix` module, if you want it.

### [`specialisation.nvidia_free.config`](./nvidia.nix#L2)
Specialisation to boot an NVIDIA GPU-based system with the fully open-source driver stack (Nouveau + Mesa + NVK). \
By default, this specialisation is not active; Instead, the system will boot with the proprietary drivers. You can choose to boot with the fully open-source driver stack at the bootloader's screen.

All the following configuration options down below will be for the proprietary drivers only.

##

### [`services.xserver.videoDrivers`](./nvidia.nix#L8)
Use the proprietary drivers for NVIDIA GPUs of the Turing generation and newer.

##

### [`boot.kernelParams`](./nvidia.nix#L10)
Kernel parameters to apply from boot:
- `nvidia.NVreg_EnableResizableBar=1`
Enable resizable BAR support.
- `nvidia.NVreg_InitializeSystemMemoryAllocations=0`
Skip over zeroing graphics memory buffers at alloc time. \
• [CachyOS GitHub: nvidia.conf](https://github.com/CachyOS/CachyOS-Settings/blob/master/usr/lib/modprobe.d/nvidia.conf#L20)
- `nvidia.NVreg_PreserveVideoMemoryAllocations=1`
Make resuming more stable.
- `nvidia.NVreg_RegistryDwords=RmEnableAggressiveVblank=1`
Lower latency when gaming; Could potentially cause some issues.
- `nvidia.NVreg_UsePageAttributeTable=1`
Fixes poor CPU performances in some cases.

##

### [`hardware.nvidia.open`](./nvidia.nix#L20)
Enable the open-source NVIDIA Kernel modules. \
Unless you use a driver version below 560, keep this to `true`.

##

### [`hardware.nvidia.powerManagement.enable`](./nvidia.nix#L21)
Enable power management through systemd. \
This can be necessary for a more stable suspend.

##

### [`hardware.nvidia-container-toolkit.enable`](./nvidia.nix#L24)
Enable dynamic CDI configuration.

##

### [`nix.settings`](./nvidia.nix#L27)
Add the CUDA binary cache to aviod having to rebuild from source too often. \
There can be some edge cases where this is not ideal. Read this NixOS Wiki page for more details: \
• [NixOS Wiki - Setting up the CUDA binary cache](https://wiki.nixos.org/wiki/CUDA#Setting_up_CUDA_Binary_Cache)

##

### [`environment.etc`](./nvidia.nix#L32)
Apply VRAM fixes to various programs in the NVIDIA drivers configuration. \
See the issue below as an example of what affected programs can behave like when this is not applied: \
• [niri-wm/niri#1962 - Docs: nvidia process profile for adjusting vram allocation behavior](https://github.com/YaLTeR/niri/issues/1962)

---

## [`packaging.nix`](./packaging.nix)
This module is imported in [`configuration.nix`](../configuration.nix).

### [`nixpkgs.config.allowUnfree`](./packaging.nix#L2)
Allow unfree/proprietary packages to be installed declaratively.

##

### [`environment.sessionVariables.NIXPKGS_ALLOW_UNFREE`](./packaging.nix#L3)
Allow unfree/proprietary pacakges to be installed in nix shells if `nixpkgs.config.allowUnfree` is `true`.

---

## [`power.nix`](./power.nix)
This module is imported in [`configuration.nix`](../configuration.nix).

### [`programs.acpi.enable`](./power.nix#L3)
• [acpi's SourceForge repository](https://sourceforge.net/projects/acpiclient/)

**`[C]`** Show battery status and other ACPI information.

This option is created by the [`acpi.nix`](../extra-modules/atemo_cajaku/programs/acpi.nix) programs module.

##

### [`programs.brightnessctl.enable`](./power.nix#L4)
• [brightnessctl's GitHub repository](https://github.com/Hummer12007/brightnessctl)

**`[C]`** Read and control device brightness.

This option is created by the [`brightnessctl.nix`](../extra-modules/atemo_cajaku/programs/brightnessctl.nix) programs module.

##

### [`programs.ddcutil.enable`](./power.nix#L5)
• [ddcutil's website](http://www.ddcutil.com/)

**`[C]`** Query and change Linux monitor settings using DDC/CI and USB.

This option is created by the [`ddcutil.nix`](../extra-modules/atemo_cajaku/programs/ddcutil.nix) programs module.

##

### [`services.logind.settings.Login`](./power.nix#L9)
Ignore power key and laptop lid actions; Instead letting the user control what they do.

##

### [`services.upower.enable`](./power.nix#L16)
• [upower's freedesktop page](https://upower.freedesktop.org/)
D-Bus service for power management.

##

### [`services.power-profiles-daemon.enable`](./power.nix#L17)
Makes user-selected power profiles handling available over D-Bus.

---

## [`printing.nix`](./printing.nix)
This module is to be imported in your device's `settings.nix` module, if you want it.

### [`services.printing.enable`](./printing.nix#L3)
• [CUPS' GitHub.io repository](https://openprinting.github.io/cups/)

Enable printing support through the CUPS daemon.

##

### [`services.printing.drivers`](./printing.nix#L4)
Additional printing and scanning drivers to install. \
A list is already provided in the module, simply uncomment the one(s) you need.

##

### [`services.avahi.enable`](./printing.nix#L22)
• [Avahi's website](http://avahi.org/)

Run the Avahi daemon for printer and scanner device discovery.

##

### [`services.avahi.nssmdns4`](./printing.nix#L23)
Enable the mDNS and NSS plug-in for IPv4.

##

### [`services.avahi.openFirewall`](./printing.nix#L24)
Open the port 5353 in the firewall for remote printers.

##

### [`programs.simple-scan.enable`](./printing.nix#L27)
• [Simple Scan's GitLab repository](https://gitlab.gnome.org/GNOME/simple-scan)

Simple scanning utility.

##

### [`users.users.${config.user.name}.extraGroups`](./printing.nix#L28)
Add the user to the printing and scanning groups.

---

## [`ssh.nix`](./ssh.nix)
This module is imported in [`configuration.nix`](../configuration.nix).

### [`services.openssh.enable`](./ssh.nix#L2)
Enable the OpenSSH daemon.

##

### [`services.openssh.ports`](./ssh.nix#L3)
Which ports the SSH daemon should listen to.

##

### [`services.openssh.settings.AllowUsers`](./ssh.nix#L6)
Login is allowed only for the listed users. By default in this configuration, only the normal user is allowed.

##

### [`services.openssh.settings.PermitRootLogin`](./ssh.nix#L7)
Whether the root user can login with SSH. By default in this configuration, this is not allowed.

##

### [`services.openssh.startWhenNeeded`](./ssh.nix#L10)
Only start an instance for each incoming connection.

---

## [`zram.nix`](./zram.nix)
This module is imported in [`configuration.nix`](../configuration.nix).

### [`zramSwap.enable`](./zram.nix#L3)
Enable in-memory compression devices and swap space provided by the zram Kernel module.

##

### [`zramSwap.algorithm`](./zram.nix#L4)
Compression algorithm to use.

##

### [`zramSwap.memoryPercent`](./zram.nix#L5)
Percentage of memory that can be stored in the zram swap devices.

##

### [`zramSwap.priority`](./zram.nix#L6)
Priority of the zram swap devices. \
It should be a number higher than the priority of your disk-based swap devices, so that the system will fill the zram swap device before falling back to disk swap.

##

### [`programs.lz4.enable`](./zram.nix#L9)
Extremely fast compression algorithm. \
Here for a faster zram swap compression.

This option is created by the [`lz4.nix`](../extra-modules/atemo_cajaku/programs/lz4.nix) programs module.