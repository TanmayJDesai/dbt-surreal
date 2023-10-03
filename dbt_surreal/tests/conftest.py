import pytest
import os

pytest_plugins = ["dbt.tests.fixtures.project"]

@pytest.fixture(scope="class")
def dbt_profile_target():
    return {
        'type': '<myadapter>',
        'threads': 1,
        'host': 'http://localhost:8000/',
        'user': 'root',
        'pass': 'root',
        'database': 'bankchurn',
        'namespace': 'dbt_tdesai',
    }

