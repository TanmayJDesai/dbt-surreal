Certainly, I can help you adapt this documentation into a README format suitable for a GitHub repository. Below is the adapted content:

---

# dbt Adapter Plugin for Surreal Database

This repository contains a dbt (data build tool) adapter plugin that allows seamless integration with the Surreal database. This README provides an overview of the key components and functionalities of the adapter plugin.

## Setup.py Documentation

The `setup.py` script is used to configure and package the Python project for distribution and installation. It defines essential information about the package, such as its name, version, description, author details, and dependencies.

```python
# Key Components Imports
from setuptools import find_namespace_packages, setup

package_name = "dbt_surreal"
package_version = "1.7.4"

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
```

## connections.py Documentation

The `connections.py` script serves as an interface between the dbt adapter and the Surreal database. It defines classes for connection management logic, including establishing connections, executing queries, handling exceptions, and managing connection states.

```python
# Key Components Import Statements
from contextlib import contextmanager
from dataclasses import dataclass
# ...

class SurrealCredentials(Credentials):
    """ Defines database-specific credentials for connecting to the Surreal adapter """
    # ...

class SurrealConnectionManager(connection_cls):
    # ...
```

## impl.py Documentation

The `impl.py` script implements the adapter-specific logic enabling dbt to interact with the Surreal database. It defines the `SurrealAdapter` class that handles and customizes adapter functionalities.

```python
# Key Components
from dbt.adapters.sql import SQLAdapter as adapter_cls
from dbt.adapters.surreal import SurrealConnectionManager

class SurrealAdapter(adapter_cls):
    """ Controls the actual implementation of the Surreal adapter """
    ConnectionManager = SurrealConnectionManager

    @classmethod
    def date_function(cls):
        return "datenow()"
```

## adapters.sql Documentation

The `adapters.sql` file contains macros, functions, and statements tailored for integration with the Surreal database. It includes a range of operations, from namespace and database switching to defining tables, functions, and more.

```sql
-- Key Components Statements
surreal__use_namespace(namespace)
surreal__use_database(database)
surreal__use_namespace_and_database(namespace, database)

-- Let Statement
surreal__let_parameter(parameter, value)

-- If Else Statement
surreal__if_else(condition, if_expression, else_if_blocks, else_expression)

-- Select Statement
surreal__select(fields, targets, conditions, split, group_by, order_by, limit, start, fetch, timeout, parallel)
```

## profile_template.yml Documentation

The `profile_template.yml` file is a configuration file for the dbt init command. It prompts users for setup when creating a new project and connection profile using the Surreal dbt Adapter.

```yaml
# Key Components Prompts
Host: Asks for the Surreal database host name.
Port: Asks for the Surreal database port number.
User: Asks for the developer's username for authentication.
Password: Asks for the developer's password for authentication.
DBName: Asks for the default database name.
Threads: Asks for the number of threads to be used.
```

---

Feel free to modify and format the above content as needed for your GitHub repository's README. This should give users an overview of the key components and functionalities of your dbt Adapter Plugin for the Surreal Database.
