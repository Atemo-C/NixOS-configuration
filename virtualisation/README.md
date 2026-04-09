# Virtualisation directory
This directory contains host virtualisation modules. Guest virtualisation additions and utilities are to be configured in your (virtual) device's `settings.nix` module. See the [`libvirt-vm/settings.nix`](../computers/libvirt-vm/settings.nix) module as an example.

## [`virt-manager.nix`](./virt-manager.nix)
If desired, this module is to be imported in your device's `settings.nix` module.

### [`programs.virt-manager.enable`](./virt-manager.nix#L1)
> [Whether to enable virt-manager, an UI for managing virtual machines in libvirt.](https://search.nixos.org/options?channel=unstable&show=programs.virt-manager.enable)

This option is built into NixOS; The [`virt-manager.nix`](../extra-modules/atemo_cajaku/programs/virt-manager.nix) programs module in this configuration applies additional configurations:
- Enablement of [`libvirtd`](https://libvirt.org/);
- Support for 3D acceleration when using an NVIDIA GPU with the proprietary drivers;
- Installation of the [`virtiofsd`](https://gitlab.com/virtio-fs/virtiofsd) package for virtual file system management and file sharing between the host and guests;
- Addition of the user to the `libvirt` group.

#### Using 3D acceleration with NVIDIA GPU with the proprietary drivers
Contrary to a lot of information online, it is possible to use 3D acceleration in Virt-Manager/libvirt with an NVIDIA GPU with the proprietary drivers. Here are the steps to follow:
1. Go to `Video Virtio` and enable 3D acceleration;
2. Go to `Display Spice` and set `Listen type` to `None`;
3. Still in `Display Spice`, make sure `OpenGL` is disabled;
4. Go to `Overview` and switch to the XML tab;
5. Add the following below the existing `<graphics>` section:
```xml
    <graphics type="egl-headless">
      <gl rendernode="/dev/dri/renderD128"/>
    </graphics>
```
6. Add the following inside the existing `<video>` section:
```xml
  <driver iommu='on' ats='on' packed='on' />
```
7. Apply the changes, and start the virtual machine.

## [`waydroid.nix`](./waydroid.nix)
If desired, this module is to be imported in your device's `settings.nix` module.

### [`virtualisation.waydroid.enable`](./waydroid.nix#L1)
> [Whether to enable Waydroid.](https://search.nixos.org/options?channel=unstable&show=virtualisation.waydroid.enable)
