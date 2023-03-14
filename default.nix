{ lib
, rustPlatform
, CoreFoundation
}:

let
  info = lib.importTOML ./Cargo.toml;
in
rustPlatform.buildRustPackage {
  pname = "mkalias";
  version = info.package.version;

  buildInputs = [ CoreFoundation ];

  src = builtins.path { name = "mkalias"; path = ./.; };

  cargoLock = {
    lockFile = ./Cargo.lock;
  };

  meta = {
    description = info.package.description;
    homepage = info.package.repository;
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.darwin;
  };
}
