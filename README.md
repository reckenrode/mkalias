`mkalias` is a very simple program to create Finder aliases without having to script Finder.  It is
based on the [approach][2] described by Howard Oakley on his blog.

## Why Not Script Finder to Create Aliases?

As described in [this article][1], granting a program the ability to script the Finder indirectly
gives it the equivalent of Full Disk Access even if the program itself has not been granted that
ability.  As of macOS 13.2.1, the example script in that article still works.

# Building

Clone the repository and do `cargo build --release`.  The binary will be found at
`target/release/mkalias` once the build completes.  If you don’t have a Rust environment,
install `cargo` with your package manager or use [rustup][3].  The MSRV is set to the version of
Rust in the nixpkgs used by the flake.  There is also [Nix][4] flake in the repository that will
set up a development environment.

[1]: https://labs.sentinelone.com/bypassing-macos-tcc-user-privacy-protections-by-accident-and-design/
[2]: https://eclecticlight.co/2018/03/16/accessing-finder-aliases-in-your-own-code-a-walk-through-alismas-source/
[3]: https://rustup.rs
[4]: https://nixos.org
