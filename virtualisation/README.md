# Virtualisation directory
This directory contains host virtualisation modules.

## [`virt-manager.nix`](./virt-manager.nix)
• [Virt Manager's website](https://virt-manager.org/) \
This module is to be imported in your device's `settings.nix` module, if you want it.

Desktop user interface for managing virtual machines with libvirtd.

This option is built into NixOs, but here are some additional configurations thanks to the [`virt-manager.nix`](../extra-modules/atemo_cajaku/programs/virt-manager.nix) programs module. Notably, it:
- Adds the user to the `libvirtd` group;
- Allows 3D acceleration with NVIDIA GPUs by adding the following to your virtual machine's XML file, follownig these steps:
1. Go to **`Video Virtio`** and enable 3D acceleration;
2. Go to **`Display Spice`** and set **`Listen type`** to **`None`**;
3. Still in **`Display Spice`**, make sure **`OpenGL`** is disabled;
4. Go to **`Overview`** and switch to the XML tab;
5. Add the following below the existing **`<graphics>`** section:
```xml
    <graphics type="egl-headless">
      <gl rendernode="/dev/dri/renderD128"/>
    </graphics>
```
6. Add the following inside the existing **`<video>`** section:
```xml
  <driver iommu='on' ats='on' packed='on' />
```

---

## [`waydroid.nix`](./waydroid.nix)
• [Waydroid's GitHub repository](https://github.com/waydroid/waydroid) \
This module is to be imported in your device's `settings.nix` module, if you want it.

Container-based approach to boot a full Android system on a regular GNU/Linux system. \
May have issues with NVIDIA GPUs and certain network services.