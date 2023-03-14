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

  src = ./.;

  cargoHash = "sha256-OG+VNDmsk68VvufWBBA4xayZm7f6QIf30JX9nBXTB3c=";

  meta = {
    description = info.package.description;
    homepage = info.package.repository;
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.darwin;
  };
}
