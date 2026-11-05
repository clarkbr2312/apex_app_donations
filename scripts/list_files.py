#!/usr/bin/env python3
"""List all files in the current directory with their sizes."""

import os
from pathlib import Path


def list_files(directory: str = ".") -> None:
    """Print all files and directories with their sizes.

    Args:
        directory: The directory to scan (default is current working directory)
    """
    dir_path = Path(directory).resolve()

    print(f"Files in {dir_path}:")
    print("-" * 60)

    total_size = 0

    for item in sorted(dir_path.iterdir()):
        if item.is_file():
            size_bytes = item.stat().st_size
            # Format size nicely (B, KB, MB, GB)
            if size_bytes < 1024:
                size_str = f"{size_bytes} B"
            elif size_bytes < 1024 ** 2:
                size_str = f"{size_bytes / 1024:.1f} KB"
            else:
                size_str = f"{size_bytes / (1024 ** 2):.1f} MB"

            print(f"{item.name}: {size_str}")
            total_size += size_bytes

    # Print summary for directories too
    dirs = [d for d in dir_path.iterdir() if d.is_dir()]
    for d in sorted(dirs, key=lambda x: -x.stat().st_size):
        print(f"\n[{d.name}]: {d.stat().st_size / (1024 ** 2):.1f} MB")


if __name__ == "__main__":
    list_files()
