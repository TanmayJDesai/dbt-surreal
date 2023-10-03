# Import the required libraries
from contextlib import contextmanager
from dataclasses import dataclass
import time
from typing import Optional
import dbt.exceptions
from dbt.adapters.base import Credentials
from dbt.adapters.sql import SQLConnectionManager as connection_cls
from dbt.contracts.connection import AdapterResponse
from dbt.logger import GLOBAL_LOGGER as logger

# Import the surrealdb library for connection functionality
import surrealdb

@dataclass
class SurrealCredentials(Credentials):
    """
    Defines database-specific credentials that get added to
    profiles.yml to connect to the new adapter
    """

    host: str
    port: int
    username: str
    password: str
    namespace: str
    database: str

    @property
    def type(self):
        """Return name of adapter."""
        return "dbt-surreal"

    @property
    def unique_field(self):
        """
        Hashed and included in anonymous telemetry to track adapter adoption.
        Pick a field that can uniquely identify one team/organization building with this adapter
        """
        return self.host

    def _connection_keys(self):
        """
        List of keys to display in the `dbt debug` output.
        """
        return ("host", "port", "username", "password", "namespace", "database")


class SurrealConnectionManager(connection_cls):
    TYPE = "surreal"

    @contextmanager
    def exception_handler(self, sql: str):
        """
        Returns a context manager that will handle exceptions raised
        from queries, catch, log, and raise dbt exceptions it knows how to handle.
        """
        try:
            yield
        except surrealdb.DatabaseError as exc:
            self.release(self.connection)

            logger.debug("Surreal adapter error: {}".format(str(exc)))
            raise dbt.exceptions.DatabaseException(str(exc))
        except Exception as exc:
            logger.debug("Error running SQL: {}".format(sql))
            logger.debug("Rolling back transaction.")
            self.release(self.connection)
            raise dbt.exceptions.RuntimeException(str(exc))

    @classmethod
    def open(cls, connection):
        """
        Receives a connection object and a Credentials object
        and moves it to the "open" state.
        """
        if connection.state == "open":
            logger.debug("Connection is already open, skipping open.")
            return connection

        credentials = connection.credentials

        try:
            db = surrealdb.Surreal("http://{host}:{port}".format(host=credentials.host, port=credentials.port))
            await db.connect()
            await db.signin({"user": credentials.username, "pass": credentials.password})
            await db.use(credentials.namespace, credentials.database)

            connection.state = "open"
            connection.handle = db
        except surrealdb.AuthenticationError as exc:
            raise dbt.exceptions.FailedToConnectException(str(exc))
        except Exception as exc:
            raise dbt.exceptions.FailedToConnectException(str(exc))
        return connection

    @classmethod
    def get_response(cls, cursor):
        code = cursor.sqlstate or "OK"
        rows = cursor.rowcount

        start_time = time.time()

        end_time = time.time()
        time_taken = end_time - start_time

        status_message = f"{code} Rows Affected: {rows}, Time Taken: {time_taken:.4f} seconds"

        return AdapterResponse(
            _message=status_message,
            code=code,
            rows_affected=rows,
            time_taken=time_taken
        )

    def cancel(self, connection):
        """
        Gets a connection object and attempts to cancel any ongoing queries.

        Note: SurrealDB may not support query cancellation, so we raise a "Not Supported" exception.
        """
        raise dbt.exceptions.NotSupportedException("Query cancellation is not supported by SurrealDB")
