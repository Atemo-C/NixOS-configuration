{
	lib,
	rustPlatform,
	fetchFromGitHub,
	installShellFiles,
	scdoc,
}:

rustPlatform.buildRustPackage (finalAttrs: {
	pname = "oniri";
	version = "1.3.10";

	src = fetchFromGitHub {
		owner = "Antiz96";
		repo = "oniri";
		tag = "v${finalAttrs.version}";
		hash = "sha256-PQq9arUMHXg/wtbcZdA7M9BhPvddK1DcK/4433m+NVs=";
	};

	cargoHash = "sha256-BG6yfBRSN9qL+9QbXA5UHSsXRlJnJY9dAzqdd98lTmw=";

	nativeBuildInputs = [
		installShellFiles
		scdoc
	];

	postInstall = ''
		scdoc < doc/man/oniri.1.scd > oniri.1
		installManPage oniri.1

		installShellCompletion \
			--bash res/completions/oniri.bash \
			--fish res/completions/oniri.fish \
			--zsh res/completions/oniri.zsh
	'';

	meta = {
		description = "Automatically maximize th only window of a Niri workspace";
		hoempage = "https://github.com/Aniz96/oniri";
		changelog = "https://github.com/Antiz96/oniri/blob/v${finalAttrs.version}/CHANGELOG.md";
		license = lib.licenses.gpl3Plus;
		platforms = lib.platforms.linux;
		mainProgram = "oniri";
	};
})