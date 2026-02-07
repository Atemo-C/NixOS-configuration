{ lib, stdenv, fetchFromGitHub, python3Packages }:
python3Packages.buildPythonApplication rec {
	pname = "midiplus-smartpad-rgb-editor";
	version = "0.1.1";

	src = fetchFromGitHub {
		owner = "Reg0lino";
		repo = "MidiPlusSmartPadRGBEditor";
		rev = "release";
		sha256 = "sha256-hpzhMUvcY4bOQmfGDGD03hCUlFF0xKWSt2K3HZseEMk=";
	};

	format = "other";

	propagatedBuildInputs = with python3Packages; [
		mido
		pyqt6
		python-rtmidi
	];

	nativeBuildInputs = [ python3Packages.wrapPython ];

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

	postPatch = ''
	substituteInPlace main_window.py \
		--replace 'self.user_data_base_path = os.path.join(project_root_dir, DEFAULT_USER_DATA_PATH)' \
			'self.user_data_base_path = os.path.join(os.environ.get("XDG_DATA_HOME", os.path.expanduser("~/.local/share")), "${pname}")'
	'';

	meta = with lib; {
		description = "A desktop application designed to conrtol RGB LEDs of the MidiPlus SmartPad and similar 8×8 MIDI controllers.";
		homepage = "https://github.com/Reg0lino/MidiPlusSmartPadRGBEditor";
		license = licenses.mit;
		maintainers = [ atemo-c ];
		platforms = platforms.linux;
	};

	doCheck = false;
}