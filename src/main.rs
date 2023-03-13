// SPDX-License-Identifier: GPL-3.0-only

use std::path::PathBuf;

use clap::Parser;

mod cfurl;

#[derive(Parser)]
#[clap(about, author, version)]
struct Options {
    #[clap(
        short = 'L',
        long,
        help = "Treat the source as a symbolic link",
        long_help = "Treat the source as a symbolic link. Instead of creating an alias \
            to the source, create an alias to the target of the source."
    )]
    read_link: bool,
    /// The target of the alias
    source: PathBuf,
    /// The name of the alias to create
    destination: PathBuf,
}

fn main() {
    let options = Options::parse();

    if let Err(error) = run(options) {
        eprintln!("ERROR: {}", error);
    }
}

fn run(mut options: Options) -> anyhow::Result<()> {
    if options.read_link {
        options.source = std::fs::read_link(&options.source)?;
    }

    cfurl::create_alias(options.source, options.destination)?;
    Ok(())
}
