{
	lib,
	stdenv,
	fetchFromGitHub,
	python3Packages,
	makeDesktopItem,
}: python3Packages.buildPythonApplication rec {
	# Package name.
	pname = "midiplus-smartpad-rgb-editor";

	# Package version.
	version = "0.1.1";

	# Package source.
	src = fetchFromGitHub {
		# Owner of the repository.
		owner = "Reg0lino";

		# Repository's name.
		repo = "MidiPlusSmartPadRGBEditor";

		# Revision.
		rev = "release";

		# Hash,
		sha256 = "sha256-hpzhMUvcY4bOQmfGDGD03hCUlFF0xKWSt2K3HZseEMk=";
	};

	# Format to use.
	format = "other";

	# Propagated build inputs.
	propagatedBuildInputs = with python3Packages; [
		mido
		pyqt6
		python-rtmidi
	];

	# Native build inputs.
	nativeBuildInputs = [ python3Packages.wrapPython ];

	# Install and make executable.
	installPhase = ''
		runHook preInstall
		mkdir -p $out/bin
		mkdir -p $out/libexec/midiplus-smartpad-rgb-editor
		cp -r . $out/libexec/midiplus-smartpad-rgb-editor
		chmod +x $out/libexec/midiplus-smartpad-rgb-editor/smartpad_rgb_app.py
		makeWrapper ${python3Packages.python}/bin/python $out/bin/smartpad-rgb-editor \
			--add-flags $out/libexec/midiplus-smartpad-rgb-editor/smartpad_rgb_app.py \
			--prefix PYTHONPATH : $PYTHONPATH:$out/libexec/midiplus-smartpad-rgb-editor
		runHook postInstall
	'';

	# Allow the configuration files to be put in `~/.local/share/midiplus-smartpad-rgb-editor/`.
	# This is necessary, since the settings would otherwise be read-only, and thus unsaved.
	postPatch = ''
	substituteInPlace main_window.py \
		--replace 'self.user_data_base_path = os.path.join(project_root_dir, DEFAULT_USER_DATA_PATH)' \
			'self.user_data_base_path = os.path.join(os.environ.get("XDG_DATA_HOME", os.path.expanduser("~/.local/share")), "${pname}")'
	'';

	# Create a .desktop file for the program.
	desktopItem = makeDesktopItem {
		desktopName = "MidiPlus SmartPad RGB Editor";
		genericName = "MidiPlus SmartPAD RGB Editor";
		name = "MidiPlus SmartPAD RGB Editor";
		comment = "Desktop application designed to control the RGB LEDs of the MidiPlus SmartPAD.";
		exec = "smartpad-rgb-editor";
		icon = "color-picker";
		categories = [ "Utility" ];
		terminal = false;
		keywords = [ "midi" "midiplus" "smartpad" "rgb" "editor" "macro" ];
	};

	meta = with lib; {
		# Package description.
		description = "A desktop application designed to conrtol RGB LEDs of the MidiPlus SmartPad and similar 8×8 MIDI controllers; With development assistance from Google's Gemini 2.5.";

		# Home page of the program.
		homepage = "https://github.com/Reg0lino/MidiPlusSmartPadRGBEditor";

		# License used by the program.
		license = licenses.mit;

		# Maintainer of this module.
		maintainers = [ atemo-c ];

		# Platforms this was built and tested on.
		# This *should* be able to build on some other platforms, but I have not tried.
		platforms = platforms.linux;
	};

	# Skip checks.
	doCheck = false;
}
