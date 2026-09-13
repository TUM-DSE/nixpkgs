{
  lib,
  rustPlatform,
  fetchFromGitHub,
  libxcrypt,
  nixosTests,
  nix-update-script,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "userborn";
  version = "1.0.1-unstable-2026-09-13";

  # nikstur/userborn#61 (id ranges) + #72 (expires), not yet released
  src = fetchFromGitHub {
    owner = "Mic92";
    repo = "userborn";
    rev = "31c668dac1d40670314659bacf7a36bc1b0c7a3f";
    hash = "sha256-qxkWJHseTMEc9VATPOj9Qw5+vCJnk5cFgK662Z3dzXs=";
  };

  sourceRoot = "${finalAttrs.src.name}/rust/userborn";

  cargoHash = "sha256-7EQy87KF3Tb32jf/iU+oALlHIrVj4mFBzYdEoJHOPJM=";

  nativeBuildInputs = [ rustPlatform.bindgenHook ];

  buildInputs = [ libxcrypt ];

  stripAllList = [ "bin" ];

  passthru = {
    updateScript = nix-update-script { };
    tests = {
      inherit (nixosTests)
        userborn
        userborn-mutable-users
        userborn-mutable-etc
        userborn-immutable-users
        userborn-immutable-etc
        userborn-static
        ;
    };
  };

  meta = {
    homepage = "https://github.com/nikstur/userborn";
    description = "Declaratively bear (manage) Linux users and groups";
    changelog = "https://github.com/nikstur/userborn/blob/${finalAttrs.version}/CHANGELOG.md";
    license = lib.licenses.mit;
    platforms = lib.platforms.unix;
    maintainers = with lib.maintainers; [ nikstur ];
    mainProgram = "userborn";
  };
})
