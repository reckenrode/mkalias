{ pkgs }:

pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    rust-bin.stable.latest.default
    libiconv
    darwin.apple_sdk.frameworks.CoreFoundation
  ];
}
