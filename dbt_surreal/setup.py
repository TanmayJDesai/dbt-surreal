#!/usr/bin/env python
from setuptools import find_namespace_packages, setup

package_name = "dbt_surreal"
# make sure this always matches dbt/adapters/{adapter}/__version__.py
package_version = "1.7.4"
description = """The Surreal adapter plugin for dbt"""

setup(
    name=package_name,
    version=package_version,
    description=description,
    long_description=description,
    author="Tanmay Desai",
    author_email="desai.j.tanmay@gmail.com",
    url="https://github.com/TanmayJDesai/Adapter-Project-DBT",
    packages=find_namespace_packages(include=["dbt", "dbt.*"]),
    include_package_data=True,
    install_requires=[
        "dbt-core~=1.7.4.",
    ],
)
