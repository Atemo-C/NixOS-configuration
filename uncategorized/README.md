# Uncategorized directory
This directory contains modules that do not fit in any particular category. This does not make them any less important, as this directory contains settings such as the bootloader, NVIDIA GPU drivers, ZRAM swap compression, and much more.

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

## [`power.nix`](./power.nix)
This module is imported in [`configuration.nix`](../configuration.nix).

### [`programs.acpi.enable`](./power.nix#L3)
**`[C]`** Show battery status and other ACPI information.

This option is created by the [`acpi.nix`](../extra-modules/atemo_cajaku/programs/acpi.nix) programs module.

##

### [`programs.brightnessctl.enable`](./power.nix#L4)
**`[C]`** Read and control device brightness.

This option is created by the [`brightnessctl.nix`](../extra-modules/atemo_cajaku/programs/brightnessctl.nix) programs module.

##

### [`programs.ddcutil.enable`](./power.nix#L5)
**`[C]`** Query and change Linux monitor settings using DDC/CI and USB.

This option is created by the [`ddcutil.nix`](../extra-modules/atemo_cajaku/programs/ddcutil.nix) programs module.

##

### [`services.logind.settings.Login`](./power.nix#L9)
Ignore power key and laptop lid actions; Instead letting the user control what they do.

##

### [`services.upower.enable`](./power.nix#L16)
D-Bus service for power management.

##

### [`services.power-profiles-daemon.enable`](./power.nix#L17)
Makes user-selected power profiles handling available over D-Bus.

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