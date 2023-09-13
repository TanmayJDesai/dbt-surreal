import pytest
from dbt.tests.util import run_dbt
from dbt_surreal.tests.functional.MainTest.fixtures import my_new_seed_csv, my_new_model_sql, my_new_model_yml

class TestExample:

    @pytest.fixture(scope="class")
    def project_config_update(self):
        return {
            "name": "example",
            "models": {"+materialized": "view"},
        }

    @pytest.fixture(scope="class")
    def seeds(self):
        return {
            "my_seed.csv": my_seed_csv,
        }

    @pytest.fixture(scope="class")
    def models(self):
        return {
            "my_new_model.sql": my_new_model_sql,
            "my_new_model.yml": my_new_model_yml,
        }

    def test_run_seed_test(self, project):

        # seed seeds
        results = run_dbt(["seed"])
        assert len(results) == 1
        # run models
        results = run_dbt(["run"])
        assert len(results) == 1
        # test tests
        results = run_dbt(["test"], expect_pass=False)  # expect failing test
        assert len(results) == 2
        result_statuses = sorted(r.status for r in results)
        assert result_statuses == ["fail", "pass"]

    @pytest.mark.xfail
    def test_build(self, project):
        """Expect a failing test"""
        results = run_dbt(["build"])
