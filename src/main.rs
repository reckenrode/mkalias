// SPDX-License-Identifier: GPL-3.0-only

use std::path::PathBuf;

use clap::Parser;

mod cfurl;

#[derive(Parser)]
#[clap(about, author, version)]
struct Options {
    /// The target of the alias
    source: PathBuf,
    /// The name of the alias to create
    destination: PathBuf,
}

fn main() {
    let options = Options::parse();
    let result = cfurl::create_alias(options.source, options.destination);
    if let Err(error) = result {
        eprintln!("ERROR: {}", error);
    }
}
