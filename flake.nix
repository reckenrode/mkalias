{
  description = "A simple command-line tool to create Finder aliases";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";

  outputs =
    { self, nixpkgs }:
    let
      inherit (nixpkgs) lib;

      forAllSystems = lib.genAttrs [
        "aarch64-darwin"
        "x86_64-darwin"
      ];
    in
    {
      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.mkShell {
            inherit (self.packages.${system}.default) buildInputs nativeBuildInputs;
            packages = lib.attrValues {
              inherit (pkgs)
                cargo
                clippy
                rustfmt
                rustc
                rust-analyzer
                ;
            };
          };
        }
      );

      apps = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          mkalias = {
            type = "app";
            program = "${lib.getBin self.packages.${system}.mkalias}/bin/mkalias";
          };
          default = self.apps.${system}.mkalias;
        }
      );

      packages = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          mkalias = pkgs.callPackage ./default.nix {
            inherit (pkgs.darwin.apple_sdk.frameworks) CoreFoundation;
          };
          default = self.packages.${system}.mkalias;
        }
      );
    };
}
