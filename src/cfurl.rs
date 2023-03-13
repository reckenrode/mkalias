// SPDX-License-Identifier: GPL-3.0-only

use std::{error::Error, path::Path, ptr};

use anyhow::anyhow;
use anyhow::Result;
use core_foundation::{
    base::{kCFAllocatorDefault, TCFType},
    error::CFError,
    url::{
        kCFURLBookmarkCreationSuitableForBookmarkFile, CFURLCreateBookmarkData, CFURLRef,
        CFURLWriteBookmarkDataToFile, CFURL,
    },
};

fn from_path(path: impl AsRef<Path>) -> Result<CFURL> {
    let path = path.as_ref();
    let is_directory = path.exists() && path.metadata()?.is_dir();
    CFURL::from_path(path, is_directory)
        .ok_or_else(|| anyhow!("{} was not valid UTF-8", path.to_string_lossy()).into())
}

pub fn create_alias(source: impl AsRef<Path>, destination: impl AsRef<Path>) -> Result<()> {
    let creation_options = kCFURLBookmarkCreationSuitableForBookmarkFile;
    let source_url = from_path(source)?;
    let destination_url = from_path(&destination)?;
    unsafe {
        let source_ref = source_url.as_CFTypeRef() as CFURLRef;
        let mut error = ptr::null_mut();
        let bookmark_data = CFURLCreateBookmarkData(
            kCFAllocatorDefault,
            source_ref,
            creation_options,
            ptr::null(),
            ptr::null(),
            &mut error,
        );
        if error.is_null() {
            let destination_ref = destination_url.as_CFTypeRef() as CFURLRef;
            let mut error = ptr::null_mut();
            let result =
                CFURLWriteBookmarkDataToFile(bookmark_data, destination_ref, 0, &mut error);
            if error.is_null() {
                if result != 0 {
                    Ok(())
                } else {
                    Err(anyhow!(
                        "Could not create alias to {}",
                        destination.as_ref().to_string_lossy()
                    ))
                }
            } else {
                Err(anyhow!("{}", CFError::wrap_under_create_rule(error)))
            }
        } else {
            Err(anyhow!("{}", CFError::wrap_under_create_rule(error)))
        }
    }
}
