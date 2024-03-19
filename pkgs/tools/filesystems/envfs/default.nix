{ rustPlatform, lib, fetchFromGitHub, nixosTests }:
rustPlatform.buildRustPackage rec {
  pname = "envfs";
  version = "1.0.5";
  src = fetchFromGitHub {
    owner = "Mic92";
    repo = "envfs";
    rev = version;
    hash = "sha256-PUCgqRuQ1tSM5eZIDZS+DnxuYpwdL+8xxSuFFvSocQI=";
  };
  cargoHash = "sha256-tZNsXO8VJO+aaTwFn8sDldTrDoK2dI+nuxUxKmhBufc=";

  passthru.tests = {
    envfs = nixosTests.envfs;
  };

  postInstall = ''
    ln -s envfs $out/bin/mount.envfs
    ln -s envfs $out/bin/mount.fuse.envfs
  '';
  meta = with lib; {
    description = "Fuse filesystem that returns symlinks to executables based on the PATH of the requesting process";
    homepage = "https://github.com/Mic92/envfs";
    license = licenses.mit;
    maintainers = with maintainers; [ mic92 ];
    platforms = platforms.linux;
  };
}
