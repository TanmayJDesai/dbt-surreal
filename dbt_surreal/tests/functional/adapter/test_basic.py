import pytest

from dbt.tests.adapter.basic.test_base import BaseSimpleMaterializations
from dbt.tests.adapter.basic.test_singular_tests import BaseSingularTests
from dbt.tests.adapter.basic.test_singular_tests_ephemeral import (
    BaseSingularTestsEphemeral
)
from dbt.tests.adapter.basic.test_empty import BaseEmpty
from dbt.tests.adapter.basic.test_ephemeral import BaseEphemeral
from dbt.tests.adapter.basic.test_incremental import BaseIncremental
from dbt.tests.adapter.basic.test_generic_tests import BaseGenericTests
from dbt.tests.adapter.basic.test_snapshot_check_cols import BaseSnapshotCheckCols
from dbt.tests.adapter.basic.test_snapshot_timestamp import BaseSnapshotTimestamp
from dbt.tests.adapter.basic.test_adapter_methods import BaseAdapterMethod

@pytest.mark.skip_profile("surrealdb")
class TestSimpleMaterializationsSurreal(BaseSimpleMaterializations):
    pass

'''
class TestSingularTestsSurreal(BaseSingularTests):
    pass


class TestSingularTestsEphemeralSurreal(BaseSingularTestsEphemeral):
    pass


class TestEmptySurreal(BaseEmpty):
    pass


class TestEphemeralSurreal(BaseEphemeral):
    pass


class TestIncrementalSurreal(BaseIncremental):
    pass


class TestGenericTestsSurreal(BaseGenericTests):
    pass


class TestSnapshotCheckColsSurreal(BaseSnapshotCheckCols):
    pass


class TestSnapshotTimestampSurreal(BaseSnapshotTimestamp):
    pass


class TestBaseAdapterMethodSurreal(BaseAdapterMethod):
    pass
'''