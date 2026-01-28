{
  description = "A simple command-line tool to create Finder aliases";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

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

      apps = forAllSystems (system: {
        mkalias = {
          type = "app";
          program = lib.getExe self.packages.${system}.mkalias;
        };
        default = self.apps.${system}.mkalias;
      });

      packages = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          mkalias = pkgs.callPackage ./default.nix { };
          default = self.packages.${system}.mkalias;
        }
      );
    };
}
