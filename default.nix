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

  cargoHash = "sha256-Esj2wyLITSK13bBnNIAca4i4fRDol4E8/aMC6MtFFT4=";

  meta = {
    description = info.package.description;
    homepage = info.package.repository;
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.darwin;
  };
}
