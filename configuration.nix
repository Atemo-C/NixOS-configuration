{ ... }: { imports = [
	# Niri Wayland compositor and essential utilities.
	./niri.nix

	# HP 250 G6 laptop.
#	./computers/hp-250-g6/hardware-configuration.nix
#	./computers/hp-250-g6/settings.nix

	# QEMU/KVM virtual machine.
#	./computers/qemu-kvm/hardware-configuration.nix
#	./computers/qemu-kvm/settings.nix

	# R5 desktop PC.
#	./computers/r5-pc/hardware-configuration.nix
#	./computers/r5-pc/settings.nix

	# ThinkPad L510 laptop.
#	./computers/thinkpad-l510/hardware-configuration.nix
#	./computers/thinkpad-l510/settings.nix

	# 3D accelaretd graphics.
	./gpu/shared.nix

	# Input configuration and utilities.
	./input/keyboard-layout.nix
	./input/opentabletdriver.nix
	./input/utilities.nix
	./input/zsa.nix

	# Various programs.
	./programs/3d.nix
	./programs/accessories.nix
	./programs/android.nix
	./programs/gaming.nix
	./programs/internet.nix
	./programs/multimedia.nix
	./programs/office.nix
	./programs/shell-utilities.nix
	./programs/system-info.nix
	./programs/terminal-emulator.nix
	./programs/text.nix

	# Storage configuration and utilities.
	./storage/file-management.nix
	./storage/file-utilities.nix
	./storage/filesystems.nix
	./storage/mounts.nix

	# Theming modules.
	./theming/fonts.nix
	./theming/icons.nix
	./theming/settings.nix
	./theming/terminal-colors.nix

	# Other modules (but still as important!).
	./uncategorized/audio.nix
	./uncategorized/bluetooth.nix
	./uncategorized/boot.nix
	./uncategorized/locale.nix
	./uncategorized/networking.nix
	./uncategorized/nix-settings.nix
	./uncategorized/packaging.nix
	./uncategorized/power.nix
	./uncategorized/printing.nix
	./uncategorized/ssh.nix
	./uncategorized/zram.nix

	# User modules.
	./user/name.nix
	./user/settings.nix
	./user/shell.nix

	# Virtualisation modules.
#	./virtualisation/docker.nix
#	./virtualisation/virt-manager.nix
#	./virtualisation/virtualbox.nix
#	./virtualisation/android.nix


	# Extra modules.
	./extra-modules/atemo/config/username.nix

	./extra-modules/atemo/programs/acpi.nix
	./extra-modules/atemo/programs/alsa-utils.nix
	./extra-modules/atemo/programs/amfora.nix
	./extra-modules/atemo/programs/android-tools.nix
	./extra-modules/atemo/programs/aspell.nix
	./extra-modules/atemo/programs/audacious.nix
	./extra-modules/atemo/programs/audacity.nix
	./extra-modules/atemo/programs/bc.nix
	./extra-modules/atemo/programs/binutils.nix
	./extra-modules/atemo/programs/blender.nix
	./extra-modules/atemo/programs/brightnessctl.nix
	./extra-modules/atemo/programs/btop.nix
	./extra-modules/atemo/programs/bzip3.nix
	./extra-modules/atemo/programs/calcurse.nix
	./extra-modules/atemo/programs/cmd-polkit.nix
	./extra-modules/atemo/programs/cpu-x.nix
	./extra-modules/atemo/programs/cuda.nix
	./extra-modules/atemo/programs/dar.nix
	./extra-modules/atemo/programs/dash.nix
	./extra-modules/atemo/programs/dcmtk.nix
	./extra-modules/atemo/programs/ddcutil.nix
	./extra-modules/atemo/programs/desktop-file-utils.nix
	./extra-modules/atemo/programs/desmume.nix
	./extra-modules/atemo/programs/dtrx.nix
	./extra-modules/atemo/programs/easytag.nix
	./extra-modules/atemo/programs/efibootmgr.nix
	./extra-modules/atemo/programs/element-desktop.nix
	./extra-modules/atemo/programs/evhz.nix
	./extra-modules/atemo/programs/evsieve.nix
	./extra-modules/atemo/programs/exfatprogs.nix
	./extra-modules/atemo/programs/exiftool.nix
	./extra-modules/atemo/programs/fastfetch.nix
	./extra-modules/atemo/programs/fd.nix
	./extra-modules/atemo/programs/f2fs-tools.nix
	./extra-modules/atemo/programs/f3d.nix
	./extra-modules/atemo/programs/ferium.nix
	./extra-modules/atemo/programs/ffmpeg.nix
	./extra-modules/atemo/programs/ffmpegthumbnailer.nix
	./extra-modules/atemo/programs/fileroller.nix
	./extra-modules/atemo/programs/freetype.nix
	./extra-modules/atemo/programs/fuzzel.nix
	./extra-modules/atemo/programs/gallery-dl.nix
	./extra-modules/atemo/programs/gcolor3.nix
	./extra-modules/atemo/programs/gh.nix
	./extra-modules/atemo/programs/gifsicle.nix
	./extra-modules/atemo/programs/gifski.nix
	./extra-modules/atemo/programs/gimp.nix
	./extra-modules/atemo/programs/gnirehtet.nix
	./extra-modules/atemo/programs/gnome-epub-thumbnailer.nix
	./extra-modules/atemo/programs/gparted.nix
	./extra-modules/atemo/programs/gstreamer.nix
	./extra-modules/atemo/programs/gucharmap.nix
	./extra-modules/atemo/programs/hdparm.nix
	./extra-modules/atemo/programs/heimdall.nix
	./extra-modules/atemo/programs/heroic.nix
	./extra-modules/atemo/programs/hfsprogs.nix
	./extra-modules/atemo/programs/hunspell.nix
	./extra-modules/atemo/programs/icoextract.nix
	./extra-modules/atemo/programs/imagemagick.nix
	./extra-modules/atemo/programs/inkscape.nix
	./extra-modules/atemo/programs/jfsutils.nix
	./extra-modules/atemo/programs/jmtpfs.nix
	./extra-modules/atemo/programs/jpegoptim.nix
	./extra-modules/atemo/programs/jq.nix
	./extra-modules/atemo/programs/jstest-gtk.nix
	./extra-modules/atemo/programs/kdenlive.nix
	./extra-modules/atemo/programs/keepassxc.nix
	./extra-modules/atemo/programs/keypunch.nix
	./extra-modules/atemo/programs/kimageformats.nix
	./extra-modules/atemo/programs/krita.nix
	./extra-modules/atemo/programs/lagrange.nix
	./extra-modules/atemo/programs/lha.nix
	./extra-modules/atemo/programs/lhasa.nix
	./extra-modules/atemo/programs/libarchive.nix
	./extra-modules/atemo/programs/libde265.nix
	./extra-modules/atemo/programs/libgsf.nix
	./extra-modules/atemo/programs/libmtp.nix
	./extra-modules/atemo/programs/libreoffice.nix
	./extra-modules/atemo/programs/libjxl.nix
	./extra-modules/atemo/programs/libwebp.nix
	./extra-modules/atemo/programs/lm_sensors.nix
	./extra-modules/atemo/programs/lsd.nix
	./extra-modules/atemo/programs/lshw.nix
	./extra-modules/atemo/programs/lz4.nix
	./extra-modules/atemo/programs/lzip.nix
	./extra-modules/atemo/programs/lzop.nix
	./extra-modules/atemo/programs/lximage-qt.nix
	./extra-modules/atemo/programs/mesa-demos.nix
	./extra-modules/atemo/programs/mgba.nix
	./extra-modules/atemo/programs/micro.nix
	./extra-modules/atemo/programs/midiplus-smartpad-rgb-editor.nix
	./extra-modules/atemo/programs/minder.nix
	./extra-modules/atemo/programs/mprime.nix
	./extra-modules/atemo/programs/mpv.nix
	./extra-modules/atemo/programs/mission-center.nix
	./extra-modules/atemo/programs/ncdu.nix
	./extra-modules/atemo/programs/nilfs-utils.nix
	./extra-modules/atemo/programs/niri.nix
	./extra-modules/atemo/programs/noctalia-shell.nix
	./extra-modules/atemo/programs/nufraw-thumbnailer.nix
	./extra-modules/atemo/programs/oxipng.nix
	./extra-modules/atemo/programs/p7zip.nix
	./extra-modules/atemo/programs/parallel.nix
	./extra-modules/atemo/programs/pcsx2.nix
	./extra-modules/atemo/programs/pmutils.nix
	./extra-modules/atemo/programs/poppler-utils.nix
	./extra-modules/atemo/programs/poppler.nix
	./extra-modules/atemo/programs/prismlauncher.nix
	./extra-modules/atemo/programs/pwvucontrol.nix
	./extra-modules/atemo/programs/qbittorrent.nix
	./extra-modules/atemo/programs/qtox.nix
	./extra-modules/atemo/programs/qpwgraph.nix
	./extra-modules/atemo/programs/qtsvg.nix
	./extra-modules/atemo/programs/rlwrap.nix
	./extra-modules/atemo/programs/rpcs3.nix
	./extra-modules/atemo/programs/ruffle.nix
	./extra-modules/atemo/programs/sc-controller.nix
	./extra-modules/atemo/programs/scrcpy.nix
	./extra-modules/atemo/programs/shellcheck.nix
	./extra-modules/atemo/programs/simple-scan.nix
	./extra-modules/atemo/programs/smartmontools.nix
	./extra-modules/atemo/programs/soundfont.nix
	./extra-modules/atemo/programs/speedtest.nix
	./extra-modules/atemo/programs/tarlz.nix
	./extra-modules/atemo/programs/tlrc.nix
	./extra-modules/atemo/programs/tor-browser.nix
	./extra-modules/atemo/programs/tor.nix
	./extra-modules/atemo/programs/trashy.nix
	./extra-modules/atemo/programs/typioca.nix
	./extra-modules/atemo/programs/udftools.nix
	./extra-modules/atemo/programs/unar.nix
	./extra-modules/atemo/programs/unzip.nix
	./extra-modules/atemo/programs/usbutils.nix
	./extra-modules/atemo/programs/v4l-utils.nix
	./extra-modules/atemo/programs/vintagestory.nix
	./extra-modules/atemo/programs/vulkan-tools.nix
	./extra-modules/atemo/programs/webp-pixbuf-loader.nix
	./extra-modules/atemo/programs/wget.nix
	./extra-modules/atemo/programs/xemu.nix
	./extra-modules/atemo/programs/xfburn.nix
	./extra-modules/atemo/programs/xfsdump.nix
	./extra-modules/atemo/programs/xfsprogs.nix
	./extra-modules/atemo/programs/xreader.nix
	./extra-modules/atemo/programs/yt-dlp.nix
	./extra-modules/atemo/programs/zsa.nix

	./extra-modules/external/home-manager.nix
	./extra-modules/external/nix-flatpak.nix
]; }