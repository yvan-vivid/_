from argparse import ArgumentParser, Namespace
from collections.abc import Iterable, Iterator
from dataclasses import dataclass
from logging import error, info, warning
from pathlib import Path
from shutil import move
from typing import Self, cast, override

from ..lib.cli import Args, bind_enum_to_args, parse_args
from ..lib.file_org import Dating, Level, Ordering


@dataclass(frozen=True)
class Params(Args):
    sources: list[Path]
    out: Path
    ordering: Ordering
    dry_run: bool = False

    @classmethod
    @override
    def from_args(cls, args: Namespace) -> Self:
        ordering = Ordering(cast(Level, args.level), Dating.Created)
        return cls(
            cast(list[Path], args.sources),
            cast(Path, args.out),
            ordering,
            cast(bool, args.dry_run),
        )


def stream_sources(sources: Iterable[Path]) -> Iterator[Path]:
    for source in sources:
        if source.is_dir():
            yield from source.iterdir()
        elif source.is_file():
            yield source
        else:
            warning(f"Ignoring {source}. Neither file nor directory")


def arg_parser() -> ArgumentParser:
    parser = ArgumentParser(
        description="Organize files by year/month/day based on modification time."
    )

    _ = parser.add_argument(
        "sources",
        nargs="+",
        type=Path,
        help="One or more source paths (files or directories).",
    )

    _ = parser.add_argument(
        "--out", type=Path, required=True, help="Destination root directory."
    )
    _ = parser.add_argument(
        "--dry-run",
        action="store_true",
        help="Simulate moves without actually moving files.",
    )

    bind_enum_to_args(Level, parser, default=Level.Month, help="Group files by")

    return parser


def main() -> None:
    params = parse_args(Params, arg_parser(), True)

    if not params.out.is_dir():
        error(
            f"Given output directory {params.out} does not exist. It must be manually created."
        )
        exit(1)

    for item in stream_sources(params.sources):
        out_path = params.out / params.ordering(item) / item.name

        if params.dry_run:
            info(f"Would move [{item}] => [{out_path}]")
        else:
            info(f"Moving [{item}] => [{out_path}]")
            out_path.parent.mkdir(parents=True, exist_ok=True)
            _ = move(item, out_path)


if __name__ == "__main__":
    main()
