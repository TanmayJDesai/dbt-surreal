Setup.py Documentation for dbt Adapter Plugin

Purpose and Structure
The setup.py script is used to configure and package a Python project for distribution and installation. It defines essential information about the package, such as its name, version, description, author details, and dependencies. The structure of the setup.py file follows a standardized format and utilizes the setup tools library to manage the package's distribution.

Key Components
Imports
	
from setuptools import find_namespace_packages, setup


The setuptools library provides functions and utilities for packaging and distribution. The find_namespace_packages function is used to locate packages under the specified namespace, and the setup function is used to configure the package setup.

Package Name and Version

package_name = "dbt_surreal"
package_version = "1.7.4"


These variables define the name and version of the package. The package name should match the directory structure and the namespace used within the project. The version is a string that represents the package's version number.

Setup Configuration

setup(
    name=package_name,
    version=package_version,
    description=description,
    long_description=description,
    author="Tanmay Desai",
    author_email="desai.j.tanmay@gmail.com",
    url="https://github.com/TanmayJDesai/Proj1",
    packages=find_namespace_packages(include=["dbt", "dbt.*"]),
    include_package_data=True,
    install_requires=[
        "dbt-core~=1.7.4.",
    ],
)

The setup function is used to configure the package setup. It takes various keyword arguments that define package metadata and behavior. Key configuration options include:

connections.py Documentation for dbt Adapter Plugin

Purpose and Structure
The connections.py script serves as an interface between the dbt adapter and the database it interacts with. It defines classes that encapsulate the connection management logic, including establishing connections, executing queries, handling exceptions, and managing connection states.

Key Components
Import Statements

from contextlib import contextmanager
from dataclasses import dataclass
import time
from typing import Optional
import dbt.exceptions
from dbt.adapters.base import Credentials
from dbt.adapters.sql import SQLConnectionManager as connection_cls
from dbt.logger import GLOBAL_LOGGER as logger

import surrealdb


Import statements bring in the required libraries and modules. These include standard Python libraries, dbt-specific modules, and the surrealdb library that facilitates the connection functionality specific to the Surreal adapter.

Credentials Dataclass

class SurrealCredentials(Credentials):
    """
    Defines database-specific credentials that get added to
    profiles.yml to connect to the new adapter
    """
    # ...


The SurrealCredentials class inherits from the Credentials class provided by dbt. It defines the necessary credentials required for connecting to the Surreal adapter, such as host, port, username, password, namespace, and database.

Connection Manager Class

class SurrealConnectionManager(connection_cls):
    TYPE = "surreal"

    @contextmanager
    def exception_handler(self, sql: str):
        # ...
    
    @classmethod
    def open(cls, connection):
        # ...
    
    @classmethod
    def get_response(cls, cursor):
        # ...
    
    def cancel(self, connection):
        # ...


The SurrealConnectionManager class inherits from the dbt SQLConnectionManager class and serves as the primary connection manager for the Surreal adapter. It includes methods such as exception_handler to handle exceptions during queries, open to establish a connection, get_response to retrieve response details, and cancel for query cancellation (if supported by the adapter).

impl.py Documentation for dbt Adapter Plugin

Purpose and Structure
The primary purpose of the impl.py script is to implement the adapter-specific logic that enables dbt to interact with the Surreal database. It defines the SurrealAdapter class that inherits from SQLAdapter (provided by dbt) and is designed to handle and customize various adapter functionalities.
Key Components
from dbt.adapters.sql import SQLAdapter as adapter_cls
from dbt.adapters.surreal import SurrealConnectionManager

class SurrealAdapter(adapter_cls):
    """
    Controls actual implementation of the adapter and ability to override certain methods.
    """
    ConnectionManager = SurrealConnectionManager
    
    @classmethod
    def date_function(cls):
        """
        Returns canonical date function
        """
        return "datenow()"


The SurrealAdapter class is at the heart of the implementation and customization process. It inherits from SQLAdapter and provides an essential interface for dbt to interact with the Surreal database. The ConnectionManager attribute specifies the SurrealConnectionManager class, which is responsible for managing database connections. The date_function method returns the canonical date function used by the adapter.

adapters.sql Documentation
Purpose and Structure
The adapters.sql file serves as the repository for all macros, functions, and statements tailored for seamless integration with the Surreal database using dbt. It encompasses a wide range of operations, from switching namespaces and databases to defining tables, functions, and more.

Key Components
Statements
Use Statements: 
surreal__use_namespace(namespace)
surreal__use_database(database)
surreal__use_namespace_and_database(namespace, database)


Let Statement
surreal__let_parameter(parameter, value)


If Else Statement 
surreal__if_else(condition, if_expression, else_if_blocks, else_expression)


Select Statement 
surreal__select(fields, targets, conditions, split, group_by, order_by, limit, start, fetch, timeout, parallel)


Insert Statement
surreal__insert(ignore, into, value, fields, values, on_duplicate_key_update)


Create Statement
surreal__create(targets, content, fields, return_option, timeout, parallel)


Update Statement
surreal__update(targets, content, merge, patch, fields, condition, return_option, timeout, parallel)


Return Statment
surreal__return(value)


Delete Statement
surreal__delete(target, where_clause='', return_value='NONE')


Remove Statement
surreal__remove(resource_type, resource_name)


Info Statement
surreal__info(level, target)


Functions
Array Functions
surreal__array_add(array, value)
surreal__array_all(array)
surreal__array_any(array)
surreal__array_append(array, value)
surreal__array_combine(array1, array2)
surreal__array_complement(array1, array2)
surreal__array_concat(array1, array2)
surreal__array_difference(array1, array2)
surreal__array_distinct(array)
surreal__array_flatten(array)
surreal__array_group(array)
surreal__array_insert(array, value, position)
surreal__array_intersect(array1, array2)
surreal__array_len(array)
surreal__array_pop(array)
surreal__array_prepend(array, value)
surreal__array_push(array, value)
surreal__array_remove(array, position)
surreal__array_reverse(array)
surreal__array_sort(array)
surreal__array_sort_asc(array)
surreal__array_sort_desc(array)
surreal__array_union(array1, array2)


Other Functions

surreal__count(value=None)
surreal__current_timestamp()


Define Statements
The DEFINE statements provide a convenient way to define and configure various entities within the Surreal adapter. These statements help define namespaces, databases, logins, tokens, scopes, tables, events, functions, fields, indexes, and parameters.

profile_template.yml Documentation dbt Adapter Plugin
Purpose and Structure
The profile_template.yml file is a crucial configuration file that enables the dbt init command to prompt users for setup when creating a new project and connection profile using the Surreal dbt Adapter. This template provides hints, default values, and conditional prompts based on connection methods that require different supporting attributes. Users can also customize this file to support their organization's needs when using your dbt adapter for the first time.

Key Components
Fixed
The fixed section specifies fixed configuration attributes for the profile. In this case, the type is set to "surreal" to indicate that the profile is intended for the Surreal dbt Adapter.
Prompts
Host 
Asks for the host name of the Surreal database. It provides a hint to the user to enter their host name.
Port
Asks for the port number of the Surreal database. It provides a default value of 8000 and specifies that the input type should be an integer.
User
Asks for the developer's username for authentication. It provides a hint to the user to enter their username.
Password
Asks for the developer's password for authentication. It provides a hint to the user to enter their password and specifies that the input should be hidden during entry.
DBName
Asks for the default database name. It provides a hint to the user to enter the default database name.
Threads
Asks for the number of threads to be used. It provides a hint that the user should enter 1 or more threads and sets the default value to 1.

