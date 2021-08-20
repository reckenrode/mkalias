{ lib
, stdenv
, darwin
, rustPlatform
}:

let
  info = lib.importTOML ./Cargo.toml;
in
rustPlatform.buildRustPackage {
  pname = "mkalias";
  version = info.package.version;

  buildInputs = [
    darwin.apple_sdk.frameworks.CoreFoundation
  ];

  src = ./.;

  cargoHash = "sha256-X8bmpzKct5mR1ybeBop3GtumcOWTjbc6pI/64kUgg70=";

  meta = let inherit (lib) licenses platforms; in {
    description = info.package.description;
    homepage = info.package.repository;
    license = licenses.gpl3Only;
    platforms = platforms.darwin;
  };
}
