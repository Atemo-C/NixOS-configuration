{ ... }: { imports = [
	# Custom modules imported globally.
	./custom-modules/programs/gnirehtet.nix
	./custom-modules/programs/heimdall.nix
	./custom-modules/programs/keymapp.nix
	./custom-modules/programs/rpcs3.nix
	./custom-modules/programs/scrcpy.nix
	./custom-modules/programs/wally-cli.nix

	./desktop/dunst.nix     # Dunst notification daemon.
	./desktop/fuzzel.nix    # Fuzzel graphical menu.
	./desktop/niri.nix      # Niri Wayland compositor.
	./desktop/swaylock.nix  # Swaylock screen locking utility.
	./desktop/utilities.nix # Various desktop utilities (polkit, keyring, wallpaper…)
	./desktop/waybar.nix    # Waybar bar.
	/* Symlinked files:
	./desktop/files/waybar/config.json > $HOME/.config/waybar/config
	./desktop/files/waybar/style.css   > $HOME/.config/waybar/style.css
	./desktop/files/niri.kdl           > $HOME/.config/niri/config.kdl
	*/

	#./gpu/nvidia.nix # NVIDIA GPU (16XX and later only) drivers only.
	./gpu/shared.nix # Shared graphic drivers and 3D acceleration.

	# Manual hardware configuration settings.
	#./hardware/devices/hp-250-g6.nix     # Laptop,  2019,      UEFI, Intel graphics.
	#/hardware/devices/r5-pc.nix         # Desktop, custom,    UEFI, NVIDIA graphics (+ integrated AMD as backup).
	#./hardware/devices/thinkpad-l510.nix # Laptop,  2009(ish), BIOS, Intel graphics.

	# Automatically-generated hardware configuration files - Do not touch them unless you fully reinstall.
	#./hardware/generated/hp-250-g6.nix
	#./hardware/generated/r5-pc.nix

	./input/keyboard-layout.nix  # Keyboard layout configuration across all environments.
	./input/opentabletdriver.nix # OpenTabletDriver as replacement for default drawing tablet drivers.
	./input/utilities.nix        # Various input utilities (joystick tester, autoclicker…)
	./input/zsa.nix              # Support for ZSA keyboards.

	./programs/3d.nix                # 3D modeling and printing.
	./programs/accessories.nix       # Various accessories (mind mapper, password manager…)
	./programs/gaming.nix            # Gaming and gaming optimisations.
	./programs/internet.nix          # Web browsing, downloading, torrent management, socials…
	./programs/multimedia.nix        # Images, videos, and other goodies (./uncategorized/audio.nix for audio).
	./programs/office.nix            # Office programs (office suite, document viewer…)
	./programs/shell-utilities.nix   # Various shell utilities (shell, calendar, calculator, git…)
	./programs/system-info.nix       # System monitoring, benchmarking, and information gathering.
	./programs/terminal-emulator.nix # Terminal emulator.
	./programs/text.nix              # Text editing, character selection, clipboard management, and spell checking.
	/* Symlinked files:
	./programs/files/micro/bindings.json            > $HOME/.config/micro/bindings.json
	./programs/files/micro/colors.json              > $HOME/.config/micro/colorschemes/atemo-colors.micro
	./programs/files/micro/init.lua                 > $HOME/.config/micro/init.lua
	./programs/files/micro/micro-foot.desktop       > $HOME/.local/share/applications/micro-foot.desktop
	./programs/files/micro/micro-footclient.desktop > $HOME/.local/share/applications/micro-footclient.desktop
	./programs/files/micro/nix.yaml                 > $HOME/.config/syntax/nix.yaml
	./programs/files/micro/settings.json            > $HOME/.config/settings.json
	./programs/files/fastfetch.jsonc                > $HOME/.config/fastfetch/config.json
	./programs/files/mpv.conf                       > $HOME/.config/mpv/mpv.conf
	./programs/files/yt-dlp                         > $HOME/.config/yt-dlp/config
	*/

	./scripts/crosshair/crosshair.nix # Simple red dot crosshair using an eww widget.

	./storage/file-management.nix # File management utilities.
	./storage/file-utilities.nix  # Various file utilites (archive formats support, CD/DVD burning, backups…)
	./storage/filesystems.nix     # Filesystem settings and filesystems support.
	./storage/mounts.nix          # Storage mounts (fstab).
	/* Symlinked files:
	./storage/files/mimeapps.list             > $HOME/.config/mimeapps.list
	./storage/files/thunar-custom-actions.xml > $HOME/.config/Thunar/uca.xml
	*/

	./theming/fonts.nix           # Font configuration.
	./theming/icons.nix           # Icon and cursor theme and configuration.
	./theming/programs.nix        # Program theme and configuration.
	./theming/terminal-colors.nix # Terminal colorscheme.

	./uncategorized/android.nix      # Android utilities and ADB support.
	./uncategorized/audio.nix        # Audio configuration and utilities.
	./uncategorized/bluetooth.nix    # Bluetooth support.
	./uncategorized/boot.nix         # Boot configuration.
	./uncategorized/cachyos-opti.nix # Optimizations pulled straight from CachyOS. Needs tweaking for each system.
	./uncategorized/locale.nix       # Locale configuration (language, time, currency, measurement…)
	./uncategorized/networking.nix   # Networking configuration.
	./uncategorized/nix-settings.nix # Nix settings.
	./uncategorized/packaging.nix    # Packaging configuration and supports (unfree software, Flatpak…)
	./uncategorized/power.nix        # Power settings.
	./uncategorized/printing.nix     # Printing and scanning support and utilities.
	./uncategorized/ssh.nix          # OpenSSH configuration.
	./uncategorized/temporary.nix    # Module containing various past and present fixes.

	./user/home-manager.nix # Support for Home Manager, managed system-wide.
	./user/name.nix         # Module where the user name and title are defined.
	./user/settings.nix     # User settings (extra groups, home directory, user type…)
	./user/shell.nix        # User shell and shell configuration (here, FISH).
	/* Symlinked files:
	./user/files/config.fish > $HOME/.config/fish/config.fish
	*/

	#./virtualisation/guest/hyperv.nix     # Guest utilities for HyperV.
	#./virtualisation/guest/qemu.nix       # Guest utilities for QEMU.
	#./virtualisation/guest/virtualbox.nix # Guest utilities for VirtualBox.
	#./virtualisation/guest/vmware-xe.nix  # Guest utilities for VMware.

	#./virtualisation/host/docker.nix       # Docker support.
	#./virtualisation/host/virt-manager.nix # QEMU/KVM and VirtManager support.
	#./virtualisation/host/virtualbox.nix   # VirtualBox support.
	#./virtualisation/host/waydroid.nix     # Waydroid support (Android).
]; }