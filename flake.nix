{
  description = "A simple command-line tool to create Finder aliases";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-21.05";
    rust-overlay.url = "github:oxalica/rust-overlay";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, flake-utils, rust-overlay, ... }:
    let
      systems = builtins.attrNames nixpkgs.legacyPackages;
    in
    flake-utils.lib.eachSystem systems (system:
      let
	      overlays = [ (import rust-overlay) ];
        pkgs = import nixpkgs { inherit system overlays; };
      in rec {
        packages.mkalias = pkgs.callPackage ./default.nix {};
        defaultPackage = packages.mkalias;

        apps.mkalias = {
          type = "app";
          program = "${packages.mkalias}/bin/mkalias";
        };
        apps.defaultApp = apps.mkalias;
        devShell = import ./shell.nix { inherit pkgs; };
      }
    );
}
