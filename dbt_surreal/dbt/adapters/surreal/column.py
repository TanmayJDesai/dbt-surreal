from dbt.adapters.base.column import Column
from dbt.dataclass_schema import dbtClassMixin
from hologram import JsonDict
from typing import Any, Optional, TypeVar, Union

Self = TypeVar("Self", bound="SurrealColumn")


class SurrealColumn(dbtClassMixin, Column):
    TYPE_MAPPING = {
        "record_id": "VARCHAR(1000)",
        "text": "TEXT",
        "numeric": "NUMERIC",
        "integer": "BIGINT",
        "boolean": "BOOLEAN",
        "datetime": "TIMESTAMP",
        "object": "JSONB",
        "array": "JSONB",
        "geometry": "JSONB",
        "future": "JSONB",
    }

    def __init__(
        self,
        type: str,
        size: Optional[int] = None,
        precision: Optional[int] = None,
        scale: Optional[int] = None,
        **kwargs: Any
    ) -> None:
        self.type = type
        self.size = size
        self.precision = precision
        self.scale = scale
        super().__init__(**kwargs)

    @property
    def data_type(self) -> str:
        sql_type = self.TYPE_MAPPING.get(self.type, "TEXT")
        if self.type in {"numeric", "integer"}:
            if self.precision is not None and self.scale is not None:
                sql_type = f"{sql_type}({self.precision},{self.scale})"
        elif self.type == "text" and self.size is not None:
            sql_type = f"{sql_type}({self.size})"
        return sql_type

    def literal(self, value: Any) -> str:
        if self.type == "boolean":
            return str(value).lower()
        elif self.type == "datetime":
            return f"TIMESTAMP '{value:%Y-%m-%d %H:%M:%S}'"
        elif self.type in {"object", "array", "geometry", "future"}:
            return str(value) 
        return super().literal(value)

    def to_column_dict(self, omit_none: bool = True, validate: bool = False) -> JsonDict:
        original_dict = super().to_column_dict(omit_none=omit_none)
        return original_dict
