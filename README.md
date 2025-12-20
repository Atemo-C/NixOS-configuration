# EXPERIMENTAL BRANCH!
# ASSUME THAT EVERYTHING HERE IS BROKEN AND UNFINSHED!
![Screenshot of my current desktop](https://github.com/Atemo-C/NixOS-configuration/blob/experimental/Desktop.webp)
Wallpaper created by Dzaka. \
https://www.dzaka.fr/galerie/frontpage

# General information
This NixOS configuration is almost exactly what I use on my own systems. \
It is a successor to my old NixOS configuration, which is now archived. \
https://github.com/Atemo-C/OLD-NixOS-Configuration

It is a single-user setup, using the Niri Wayland compositor as the Wayland compositor. \
https://github.com/YaLTeR/niri

It is based entirely on NixOS unstable, and relies partially on Home Manager (but does not use Flakes). \
https://github.com/nix-community/home-manager

It uses lots of custom Nix modules, most simply replacing package lists by `programs.` options whenever possible. This is mostly a stylistic choice, but some modules do add some functionality and pre-configurations. \
https://github.com/Atemo-C/NixOS-configuration/blob/experimental/nix-modules/

# Made for a specific installation
This NixOS configuration is not made to be something anyone can just use on their own systems; Not without tweaks, at least. I have a pretty consistent way of setting up most of my computers when I install NixOS. \
Below are the steps I take to install NixOS on my devices.

## Downloading NixOS
Since I use NixOS unstable, I download the unstable ISO image too. Graphical or not, it matters not for me, but if you need to use a graphical environment during the installation, go with the graphical one. \
https://channels.nixos.org/nixos-unstable/latest-nixos-graphical-x86_64-linux.iso \
https://channels.nixos.org/nixos-unstable/latest-nixos-minimal-x86_64-linux.iso

## Creating a bootable NixOS medium
The NixOS ISO, be it graphical or not, is too big to fit on a CD. As such, a DVD or any removeable and bootable storage medium with above 4 GB of free storage space is necessary. \
In my use case, I always use a USB flash drive. You may decide to use software such as Balena Etcher, Fedora Media Writer, Ventoy, or other popular flashing utilities for writing the ISO image to it. I will simply be using `dd`. All data on it will be erased.
```shell
run0 dd bs=4M if=/path/to/file.iso of=/path/to/drive conv=fsync oflag=direct status=progress
```
Notes:
- I use `run0`, but you may use `sudo`, `doas`, or simply login to your `root` account.
- Replace `/path/to/file.iso` with the path of the downloaded NixOS ISO (e.g. `Downloads/latest-nixos-graphical-x86_64-linux.iso`)
- Replace `/path/to/drive` to the path of your USB flash storage (e.g. `/dev/sde`).

## Setting up the computer for installation
### BIOS settings
All I do is disable Secure Boot in the BIOS settings. Depending on your hardware and on your software needs, you might configure whatever else you may wish to.

### Power and networking stability
If using a laptop, it is always a good idea to keep it plugged in to a stable power source during installation. Using wired Ethernet is also preferable when possible.

### Booting into NixOS
Insert your installation medium into the target computer, and start it. If your computer does not automatically boot to the installation medium, you can go into your BIOS' settings to change the boot order or temporarily boot from a list of detected devices. \
Once you have booted, make sure to configure your keyboard layout and networking if necessary.

## Installing NixOS

### Partitioning
In my installations, I usually use an encrypted, single-drive setup, with encrypted backups to other drives on an EFI system. You can easily adapt the following steps for a multi-drive setup and a BIOS-only system. \
I will be using command-line utilities, but plenty of graphical ones and alternative command-line ones exists.
All data WILL be erased on the selected drive. Be careful.

0. Enter a shell as root with `sudo -i`.
1. List the current storage devices with `lsblk`, and see which one you want to use.
Here, we will assume `/dev/sda`, and that `/dev/sda` is a clean drive.
If it is not a clean drive, `fdisk` will ask you for confirmation at some points, so adapt the steps below accordingly.
```shell
lsblk
```
2. Open the desired storage device with `fdisk`.
```shell
fdisk /dev/sda
```
3. Create a GPT partitioning table on the drive.
```shell
g
```
4. Create a 1GB EFI boot partition.
```shell
n
[Enter] (×2)
+1G
t
1
```
5. Create a swap partition of your desired size.
Here, we will assume 8 GB.
```shell
n
[Enter] (×2)
+8G
t
[Enter]
82
```
6. Create an empty partition for the main storage that takes the remaining space.
```shell
n
[Enter] (×3)
```
7. Write the changes to the disk and exit.
```shell
w
```

### Formatting and mounting
0. I use LUKS encryption. If you do not, you may skip the relevant encryption steps and adapt the rest for your setup.

1. Format the EFI boot partition to FAT32.
```shell
mkfs.fat -F 32 -n BOOT /dev/sda1
```
2. Set up LUKS encryption for the swap and root partitions.
For convenience, you may use the same strong password for them.
```shell
cryptsetup --verify-passphrase luksFormat --label swap /dev/sda2
cryptsetup --verify-passphrase luksFormat --label root /dev/sda3
```
3. Create backup headers to store somewhere safe.
This is useful in case they ever get corrupted somehow. Keep them in a safe, external storage device.
```shell
cryptsetup luksHeaderBackup /dev/sda2 -header-backup-file luks-header-backup-swap.bin
cryptsetup luksHeaderBackup /dev/sda3 -header-backup-file luks-header-backup-root.bin
```
4. Open the encrypted swap and storage partitions.
If not on an SSD, do not use the `allow-discards` option used bellow (SSD trimming).
```shell
cryptsetup open --allow-discards /dev/sda2 swap
cryptsetup open --allow-discards /dev/sda3 root
```
5. Format the swap volume.
```shell
mkswap -L Swap /dev/mapper/swap
```
6. Turn the swap on.
```shell
swapon /dev/mapper/swap
```
7. Format the storage volume.
I use Btrfs, you may use whichever filesystem works best for you.
If you do not use Btrfs, skip/change steps related to Btrfs subvolumes and options.
```shell
mkfs.btrfs -L Storage /dev/mapper/root
```
8. Mount the root volume to /mnt.
```shell
mount -t btrfs /dev/mapper/root /mnt
```
9. Create the Btrfs subvolumes of your choice.
Here, they will be @ (root), @home, and @nix.
```shell
btrfs subvolume create /mnt/{@,@home,@nix}
```
10. Unmount the root volume.
```shell
umount /mnt
```
11. Mount the root volume with the adequate Btrfs subvolume.
Additionally here, zstd compression is enabled.
```shell
mount -o subvol=@,compress=zstd:3 /dev/mapper/root /mnt
```
12. Create the mount points for the boot partition and other desired Btrfs subvolumes.
```shell
mkdir /mnt/{boot,home,nix}
```
13. Mount the other Btrfs subvolumes.
Additionally here, zstd compression is enabled, and `noatime` is used for the nix subvolume to reduce unecessary writes.
```shell
mount -o subvol=@home,compress=zstd:3 /dev/mapper/root /mnt/home
mount -o subvol=@nix,compress=zstd:3,noatime /dev/mapper/root /mnt/nix
```
14. Mount the boot partiton.
```shell
mount -o umask=077 /dev/sda1 /mnt/boot
```

### Creating and modifying the NixOS configuration.
1. Generate the default NixOS configuration and hardware configuration file.
```shell
nixos-generate-config --root /mnt
```
2. Move the hardware configuration file.
```shell
cp /mnt/etc/nixos/hardware-configuration.nix ~/
```
3. Remove the default `configuration.nix` module, since we will be cloning this repository.
```shell
rm /mnt/etc/nixos/configuration.nix
```
4. Clone this repository to `/mnt/etc/nixos/`.
```shell
git clone https://github.com/Atemo-C/NixOS-configuration/tree/experimental /etc/nixos/
```
5. Move your hardware configuration file to `/mnt/etc/nixos/computers/your-comuputer-name`.
Replace `your-computer-name` with the name of your computer.
```shell
mkdir /mnt/etc/nixos/computers/your-computer-name
mv ~/hardware-configuration.nix /mnt/etc/nixos/computers/your-computer-name/
```
6. Get the UUID of your encrypted storage partitions.
We will directly write them to `/mnt/etc/nixos/computers/your-computer-name/settings.nix`.
This module is where we will manually configure the device-specific options.
```shell
blkid /dev/sda2 >> /mnt/etc/nixos/computers/your-computer-name/settings.nix
blkid /dev/sda3 >> /mnt/etc/nixos/computers/your-computer-name/settings.nix
```
7. Open this module with your preferred text editor.
In this live environment, you can install whichever text editor you may wish want with `nix-env -iA nixos.package-here`.
```shell
your-editor /mnt/etc/nixos/computers/your-computer-name/settings.nix
```