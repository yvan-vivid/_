from dataclasses import dataclass
from datetime import datetime
from enum import StrEnum
from pathlib import Path


class Level(StrEnum):
    Year = "year"
    Month = "month"
    Day = "day"

    def __call__(self, dt: datetime) -> Path:
        match self:
            case self.Year:
                return Path(dt.strftime("%Y"))
            case self.Month:
                return Path(dt.strftime("%Y/%m"))
            case self.Day:
                return Path(dt.strftime("%Y/%m/%d"))


class Dating(StrEnum):
    Created = "created"

    def _stat_date(self, path: Path) -> float:
        match self:
            case self.Created:
                return path.stat().st_ctime

    def __call__(self, path: Path) -> datetime:
        return datetime.fromtimestamp(self._stat_date(path))


@dataclass(frozen=True)
class Ordering:
    level: Level
    dating: Dating

    def __call__(self, path: Path) -> Path:
        return self.level(self.dating(path))
