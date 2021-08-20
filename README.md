`mkalias` is a very simple program to create Finder aliases without having to script Finder.  It is
based on the [approach][1] described by Howard Oakley on his blog.

# Building

Clone the repository and do `cargo build --release`.  The binary will be found at
`target/release/mkalias` once the build completes.  If you don’t have a Rust environment,
install `cargo` with your package manager or use [rustup][2].  I don’t have a minimum-supported Rust
version, so assume I’m using the latest.  There is also [Nix][3] flake in the repository that will
set up a development environment.

[1]: https://eclecticlight.co/2018/03/16/accessing-finder-aliases-in-your-own-code-a-walk-through-alismas-source/
[2]: https://rustup.rs
[3]: https://nixos.org
