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

# A weird way to install packages
You might notice that the vast majority of packages installed here are actually "enabled", just like most `programs.<name>.enable` options. Well, not quite, still. \
For reasons that are beyond me, the use of `environment.systemPackages = with pkgs; [];` *and* `programs.<name>.enable` infuriates me, and it is also not the least confusing thing for new users. \
So I have implemented something that is ever-so-slightly more logical to my silly brain:
- `programs.<name>.enable`, which is already present in NixOS, for installed programs that come with more advanced configurations or have additional options attached to them;
- `programs.<name>.install`, which simply installs a package with no additional configuration.
This also makes conditionals easier to wrap my head around, and avoids silly things like having an infinite recursion when I try to disable `programs.nano.enable` only if another text editor is installed (here, `micro`). \
Nothing stops you from not using these, but note that some of these modules do actually add some functionality. For example, my module for Vintage Story has an option to open relevant firewall ports for local LAN and worldwide online play from one's singleplayer world, not unlike Steam has for Remote Play.

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
8. In it, we will find our UUID for the encrypted storage partitions.
We will add them to `boot.initrd.luks.devices`, and set up other settings, such as:
- The computer's host name.
- The keyboard layout(s) to be used on it.
- Whether to enable/disable Modem Manager for cellular data.
- Filesystem-specific options (Btrfs compression, etc).
- Any other device-specific configuration that you may want.
In this example, I will be configuring my HP 250 G6:
```nix
{ ... }: {
	boot = {
		# Define the LUKS-encrypted storage devices (swap and root).
		initrd.luks.devices = {
			swap.device = "/dev/disk/by-uuid/56c4a6c9-e2d5-4b02-a13d-45ad9302a19e";
			root.device = "/dev/disk/by-uuid/80ef44a6-7ee0-4001-bc09-7b5fcd11b46e";
		};

		# Whether to let the installation process modify EFI boot variables.
		# If you have errors when updating NixOS after it has already been installed, as in,
		# if the bootloader fails to "install" again after a rebuild, it is safe to trun this of.
		loader.efi.canTouchEfiVariables = true;
	};

	# Filesystem options.
	fileSystems = {
		"/".options = [ "compress=zstd:3" ];
		"/home".options = [ "compress=zstd:3" ];
		"/nix".options = [ "compress=zstd:3" "noatime" ];
	};

	# Set the computer's name on the network.
	networking.hostName = "HP-250-G6";

	# Keyboard layout settings.
	# To see a complete list of layouts, variants, and other settings:
	# • https://gist.github.com/jatcwang/ae3b7019f219b8cdc6798329108c9aee
	#
	# To see why this list cannot easily be seen within NixOS:
	# • https://github.com/NixOS/nixpkgs/issues/254523
	# • https://github.com/NixOS/nixpkgs/issues/286283
	services.xserver.xkb = {
		layout = "fr,us";
		variant = ",intl";
	};

	# Disable the ModemManager service to improve boto times and save resources.
	# Only enable if using cellular data (tethering from a mobile device does not count).
	systemd.services.ModemManager.enable = false;
}
```
9. Modify the rest of the NixOS configuration to fit your own needs.
This includes things such as:
- The user's name and title. \
https://github.com/Atemo-C/NixOS-configuration/blob/experimental/user/name.nix
- Whether to enable support for NVIDIA GPUs (1650 and above). \
https://github.com/Atemo-C/NixOS-configuration/blob/experimental/gpu/nvidia.nix
- Various other settings, programs, etc.

### Installing NixOS
1. Install NixOS. You may choose to set or skip the root password.
```shell
nixos-install --no-root-password
```
2. Once it has installed, set your user's password.
```shell
nixos-enter --root /mnt
passwd your-user-here
exit
```
3. You can now safely power off the system, remove the installation medium, and boot into the full NixOS installation.

# Use cases and feature implementation
## Targeted use-case
- Single user.
- Personal computing.
- x86_64 desktop and laptops.
- The default **user** shell is the FISH shell.
- This entire configuration is for me, it may not work well for you.

## Not yet implemented or thoroughly tested, including but not limited to:
- Accessiblity features.
- Touchscreen support.
- Remote desktop through RDP or other.
- Computers with:
	- A non-x86_64 CPU architecture.
	- Hybrid GPU setup (e.g. NVIDIA PRIME).
	- Less than 2 GiB of RAM (swap will be heavily used with less than 6 when building the system).
	- Less than 32 GiB of storage (some Nix storage optimizations are already enabled).

# Some useful NixOS resources
Help is available in:
- The configuration.nix(5) man page.
- The on-device manual by running `nixos-help`.
- The online manual at https://nixos.org/manual/nixos/unstable/index.html
- The NixOS Wiki at https://wiki.nixos.org
- The Nix.dev documentation for the nix ecosystem at https://nix.dev

• A searchable list of available packages can be found here: \
https://search.nixos.org/packages?channel=unstable

• A searchable list of available options can be found here: \
https://search.nixos.org/options?channel=unstable

• A list of available options for Home Manager can be found here: \
https://nix-community.github.io/home-manager/options.xhtml