{
  callPackage,
  nixosTests,
  ...
}@args:

callPackage ./generic.nix args {
  # You have to ensure that in `pkgs/top-level/linux-kernels.nix`
  # this attribute is the correct one for this package.
  kernelModuleAttribute = "zfs_unstable";

  kernelMinSupportedMajorMinor = "4.18";
  kernelMaxSupportedMajorMinor = "7.2";

  # this package should point to a version / git revision compatible with the latest kernel release
  # IMPORTANT: Always use a tagged release candidate or commits from the
  # zfs-<version>-staging branch, because this is tested by the OpenZFS
  # maintainers.
  # Using master because it has FIDEDUPERANGE support merged.
  version = "2.4.99-unstable-2026-09-01";
  rev = "013d73a9bfcbcffbbc3010a912fe3d6c501a9634";

  # if adding a patch here, check if it also needs to be applied to the stable branches
  extraPatches = [ ];

  tests = {
    inherit (nixosTests.zfs) unstable;
  };

  hash = "sha256-hRL1iOymDMq1G/MXtChMUZy7TwNuRFa6SmqaXMpG9fc=";

  extraLongDescription = ''
    This is "unstable" ZFS, and will usually be a pre-release version of ZFS.
    It may be less well-tested and have critical bugs.
  '';
}
