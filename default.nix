{
  lib,
  rustPlatform,
}:

let
  info = lib.importTOML ./Cargo.toml;
in
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "mkalias";
  version = info.package.version;

  src = builtins.path {
    name = "mkalias";
    path = ./.;
  };

  cargoDeps = rustPlatform.fetchCargoVendor {
    inherit (finalAttrs)
      pname
      version
      src
      ;
    hash = "sha256-DctFVkjZwATZasYMZvfdktorF2rPgmV5nF9rOmTiSK8=";
  };

  meta = {
    mainProgram = "mkalias";
    description = info.package.description;
    homepage = info.package.repository;
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.darwin;
  };
})
