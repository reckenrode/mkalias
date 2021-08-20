// SPDX-License-Identifier: GPL-3.0-only

use std::path::PathBuf;

use structopt::StructOpt;

mod cfurl;

#[derive(StructOpt)]
#[structopt(about, author)]
struct Options {
    source: PathBuf,
    destination: PathBuf,
}

fn main() {
    let options = Options::from_args();
    let result = cfurl::create_alias(options.source, options.destination);
    if let Err(error) = result {
        eprintln!("ERROR: {}", error);
    }
}
