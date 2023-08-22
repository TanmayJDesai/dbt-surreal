from dbt.adapters.surreal.connections import SurrealConnectionManager # noqa
from dbt.adapters.surreal.connections import SurrealCredentials
from dbt.adapters.surreal.impl import SurrealAdapter

from dbt.adapters.base import AdapterPlugin
from dbt.include import surreal


Plugin = AdapterPlugin(
    adapter=SurrealAdapter,
    credentials=SurrealCredentials,
    include_path=surreal.PACKAGE_PATH
    )
