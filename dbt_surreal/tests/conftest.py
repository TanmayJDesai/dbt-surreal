import pytest

import os
# import json

# Import the functional fixtures as a plugin
# Note: fixtures with session scope need to be local

pytest_plugins = ["dbt.tests.fixtures.project"]


# The profile dictionary, used to write out profiles.yml
@pytest.fixture(scope="class")
def dbt_profile_target():
    return {
        'type': '<myadapter>',
        'threads': 1,
        'host': 'http://localhost:8000/',
        'user': 'root',
        'pass': 'root',
        'database' : 'bankchurn',
        'namespace': 'dbt_tdesai',





    }

