from abc import ABC, abstractmethod
from argparse import ArgumentParser, Namespace
from enum import StrEnum
from logging import INFO, WARNING, getLogger
from typing import Self, cast


class Args(ABC):
    @classmethod
    @abstractmethod
    def from_args(cls, args: Namespace) -> Self: ...


def bind_enum_to_args[E: StrEnum](
    e: type[E],
    parser: ArgumentParser,
    /,
    help: str | None = None,
    prefix: str | None = None,
    default: E | None = None,
) -> None:
    group = parser.add_mutually_exclusive_group()
    for item in e:
        help_str = None if help is None else f"{help}: {item.value}"
        flag = "" if prefix is None else f"{prefix}-"
        _ = group.add_argument(
            f"--{flag}{item.value}",
            action="store_const",
            dest="level",
            const=item,
            help=help_str,
        )

    if default is not None:
        parser.set_defaults(level=default)


def parse_args[P: Args](
    params_type: type[P], parser: ArgumentParser, verbose: bool = False
) -> P:
    if verbose:
        _ = parser.add_argument(
            "--verbose",
            action="store_true",
            help="Log info.",
        )

    params = parser.parse_args()

    if verbose:
        getLogger().setLevel(INFO if cast(bool, params.verbose) else WARNING)

    return params_type.from_args(params)
