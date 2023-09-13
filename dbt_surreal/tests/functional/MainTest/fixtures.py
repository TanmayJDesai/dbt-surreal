# seeds/my_new_seed.csv
my_new_seed_csv = """
id,name,age
1,John,25
2,Alice,30
3,Michael,22
4,Emily,28
""".lstrip()

# models/my_new_model.sql
my_new_model_sql = """
select * from {{ ref('my_new_seed') }}
union all
select null as id, null as name, null as age
"""

# models/my_new_model.yml
my_new_model_yml = """
version: 2
models:
  - name: my_new_model
    columns:
      - name: id
        tests:
          - unique
          - not_null
      - name: name
        tests:
          - not_null
      - name: age
        tests:
          - not_null
"""
