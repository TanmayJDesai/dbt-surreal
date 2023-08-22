/* For examples of how to fill out the macros please refer to the postgres adapter and docs
postgres adapter macros: https://github.com/dbt-labs/dbt-core/blob/main/plugins/postgres/dbt/include/postgres/macros/adapters.sql
dbt docs: https://docs.getdbt.com/docs/contributing/building-a-new-adapter
*/

/* These ARE ALL THE STATEMENTS */

-- USE STATEMENT
{% macro surreal__use_namespace(namespace) -%}
'''Switches to the specified namespace.'''
/*
    1. Use the USE statement to switch to the specified namespace
*/
USE NS {{ namespace }};
{% endmacro %}

{% macro surreal__use_database(database) -%}
'''Switches to the specified database.'''
/*
    1. Use the USE statement to switch to the specified database
*/
USE DB {{ database }};
{% endmacro %}

{% macro surreal__use_namespace_and_database(namespace, database) -%}
'''Switches to the specified namespace and database.'''
/*
    1. Use the USE statement to switch to the specified namespace and database
*/
USE NS {{ namespace }} DB {{ database }};
{% endmacro %}

-- LET STATEMENT
{% macro surreal__let_parameter(parameter, value) -%}
'''Sets and stores a value for a parameter.'''
/*
    1. Use the LET statement to set and store a value for a parameter
*/
LET ${{ parameter }} = {{ value }};
{% endmacro %}

-- IF ELSE STATEMENT
{% macro surreal__if_else(condition, if_expression, else_if_blocks, else_expression) -%}
IF {{ condition }} THEN
    {{ if_expression }}
{% for else_if_condition, else_if_expression in else_if_blocks %}
ELSE IF {{ else_if_condition }} THEN
    {{ else_if_expression }}
{% endfor %}
ELSE
    {{ else_expression }}
END;
{% endmacro %}

-- SELECT STATMENT
{% macro surreal__select(fields, targets, conditions, split, group_by, order_by, limit, start, fetch, timeout, parallel) -%}
    SELECT
        {% if fields %}
            {{ fields|join(', ') }}
        {% else %}
            *
        {% endif %}
    FROM
        {{ targets|join(', ') }}
    {% if conditions %}
        WHERE {{ conditions }}
    {% endif %}
    {% if split %}
        SPLIT {{ split|join(', ') }}
    {% endif %}
    {% if group_by %}
        GROUP BY {{ group_by|join(', ') }}
    {% endif %}
    {% if order_by %}
        ORDER BY {{ order_by|join(', ') }}
    {% endif %}
    {% if limit %}
        LIMIT {{ limit }}
    {% endif %}
    {% if start %}
        START {{ start }}
    {% endif %}
    {% if fetch %}
        FETCH {{ fetch|join(', ') }}
    {% endif %}
    {% if timeout %}
        TIMEOUT {{ timeout }}
    {% endif %}
    {% if parallel %}
        PARALLEL
    {% endif %};
{% endmacro %}

-- INSERT STATEMENT
{% macro surreal__insert(ignore, into, value, fields, values, on_duplicate_key_update) -%}
    INSERT {% if ignore %}IGNORE {% endif %}INTO {{ into }}
    {% if value %}
        {{ value }}
    {% else %}
        ({% if fields %}{{ fields|join(', ') }}{% endif %}) VALUES ({% if values %}{{ values|join(', ') }}{% endif %})
        {% if on_duplicate_key_update %}
            ON DUPLICATE KEY UPDATE {{ on_duplicate_key_update|join(', ') }}
        {% endif %}
    {% endif %}
    ;
{% endmacro %}

-- CREATE STATEMENT
{% macro surreal__create(targets, content, fields, return_option, timeout, parallel) -%}
    CREATE {{ targets }}
    {% if content %}
        CONTENT {{ content }}
    {% else %}
        SET {{ fields|join(', ') }}
    {% endif %}
    {% if return_option %}
        RETURN {{ return_option }}
    {% endif %}
    {% if timeout %}
        TIMEOUT {{ timeout }}
    {% endif %}
    {% if parallel %}
        PARALLEL
    {% endif %}
    ;
{% endmacro %}

-- UPDATE STATEMENT
{% macro surreal__update(targets, content, merge, patch, fields, condition, return_option, timeout, parallel) -%}
    UPDATE {{ targets }}
    {% if content %}
        CONTENT {{ content }}
    {% elif merge %}
        MERGE {{ merge }}
    {% elif patch %}
        PATCH {{ patch }}
    {% else %}
        SET {{ fields|join(', ') }}
    {% endif %}
    {% if condition %}
        WHERE {{ condition }}
    {% endif %}
    {% if return_option %}
        RETURN {{ return_option }}
    {% endif %}
    {% if timeout %}
        TIMEOUT {{ timeout }}
    {% endif %}
    {% if parallel %}
        PARALLEL
    {% endif %}
    ;
{% endmacro %}

-- RETURN STATEMENT
{% macro surreal__return(value) -%}
    RETURN {{ value }};
{% endmacro %}

-- DELETE STATEMENT
{% macro surreal__delete(target, where_clause='', return_value='NONE') -%}
    DELETE {{ target }}
    {%- if where_clause %} WHERE {{ where_clause }} {% endif %}
    RETURN {{ return_value }};
{% endmacro %}

-- REMOVE STATEMENT
{% macro surreal__remove(resource_type, resource_name) -%}
    REMOVE {{ resource_type }} {{ resource_name }}
    ;
{% endmacro %}

-- INFO STATEMENT
{% macro surreal__info(level, target) -%}
    INFO FOR {{ level|upper }} {{ target }};
{% endmacro %}

/* These ARE ALL THE FUNCTIONS */

--ARRAY FUNCTION
{% macro surreal__array_function(func_name, args) -%}
    {{ func_name }}({{ args|join(', ') }})
{%- endmacro %}

{% macro surreal__array_add(array, value) -%}
    {{ surreal__array_function("array::add", [array, value]) }}
{%- endmacro %}

{% macro surreal__array_all(array) -%}
    {{ surreal__array_function("array::all", [array]) }}
{%- endmacro %}

{% macro surreal__array_any(array) -%}
    {{ surreal__array_function("array::any", [array]) }}
{%- endmacro %}

{% macro surreal__array_append(array, value) -%}
    {{ surreal__array_function("array::append", [array, value]) }}
{%- endmacro %}

{% macro surreal__array_combine(array1, array2) -%}
    {{ surreal__array_function("array::combine", [array1, array2]) }}
{%- endmacro %}

{% macro surreal__array_complement(array1, array2) -%}
    {{ surreal__array_function("array::complement", [array1, array2]) }}
{%- endmacro %}

{% macro surreal__array_concat(array1, array2) -%}
    {{ surreal__array_function("array::concat", [array1, array2]) }}
{%- endmacro %}

{% macro surreal__array_difference(array1, array2) -%}
    {{ surreal__array_function("array::difference", [array1, array2]) }}
{%- endmacro %}

{% macro surreal__array_distinct(array) -%}
    {{ surreal__array_function("array::distinct", [array]) }}
{%- endmacro %}

{% macro surreal__array_flatten(array) -%}
    {{ surreal__array_function("array::flatten", [array]) }}
{%- endmacro %}

{% macro surreal__array_group(array) -%}
    {{ surreal__array_function("array::group", [array]) }}
{%- endmacro %}

{% macro surreal__array_insert(array, value, position) -%}
    {{ surreal__array_function("array::insert", [array, value, position]) }}
{%- endmacro %}

{% macro surreal__array_intersect(array1, array2) -%}
    {{ surreal__array_function("array::intersect", [array1, array2]) }}
{%- endmacro %}

{% macro surreal__array_len(array) -%}
    {{ surreal__array_function("array::len", [array]) }}
{%- endmacro %}

{% macro surreal__array_pop(array) -%}
    {{ surreal__array_function("array::pop", [array]) }}
{%- endmacro %}

{% macro surreal__array_prepend(array, value) -%}
    {{ surreal__array_function("array::prepend", [array, value]) }}
{%- endmacro %}

{% macro surreal__array_push(array, value) -%}
    {{ surreal__array_function("array::push", [array, value]) }}
{%- endmacro %}

{% macro surreal__array_remove(array, position) -%}
    {{ surreal__array_function("array::remove", [array, position]) }}
{%- endmacro %}

{% macro surreal__array_reverse(array) -%}
    {{ surreal__array_function("array::reverse", [array]) }}
{%- endmacro %}

{% macro surreal__array_sort(array) -%}
    {{ surreal__array_function("array::sort", [array]) }}
{%- endmacro %}

{% macro surreal__array_sort_asc(array) -%}
    {{ surreal__array_function("array::sort::asc", [array]) }}
{%- endmacro %}

{% macro surreal__array_sort_desc(array) -%}
    {{ surreal__array_function("array::sort::desc", [array]) }}
{%- endmacro %}

{% macro surreal__array_union(array1, array2) -%}
    {{ surreal__array_function("array::union", [array1, array2]) }}
{%- endmacro %}

-- COUNT FUNCTION
{% macro surreal__count(value=None) -%}
    {% if value is none %}
        COUNT()
    {% else %}
        COUNT({{ value }})
    {% endif %}
{% endmacro %}

-- CURRENT TIME FUNCTION

{% macro surreal__current_timestamp() -%}
'''Returns current UTC time'''
SELECT time::now();
{% endmacro %}

/* ALL DEFINE FUNCTIONS*/

-- DEFINE NAMESPACE
{% macro surreal__define_namespace(namespace_name) -%}
DEFINE NAMESPACE {{ namespace_name }}
{% endmacro %}

-- DEFINE DATABASE
{% macro surreal__define_database(database_name, namespace) -%}
USE NS {{ namespace }};
DEFINE DATABASE {{ database_name }};
{% endmacro %}

-- DEFINE LOGIN
{% macro surreal__define_login(login_name, level, namespace=None, database=None, password=None, passhash=None) -%}
{% if level == 'NAMESPACE' %}
USE NS {{ namespace }};
{% elif level == 'DATABASE' %}
USE NS {{ namespace }} DB {{ database }};
{% endif %}
DEFINE LOGIN {{ login_name }} ON {{ level }} {% if password is not none %}PASSWORD '{{ password }}'{% elif passhash is not none %}PASSHASH '{{ passhash }}'{% endif %};
{% endmacro %}

-- DEFINE TOKEN
{% macro surreal__define_token(token_name, level, namespace=None, database=None, scope=None, token_type, token_value) -%}
{% if level == 'NAMESPACE' %}
-- Specify the namespace for the token
USE NS {{ namespace }};
{% elif level == 'DATABASE' %}
-- Specify the namespace and database for the token
USE NS {{ namespace }} DB {{ database }};
{% elif level == 'SCOPE' %}
-- Specify the namespace and database for the token
USE NS {{ namespace }} DB {{ database }};
-- Define the scope
DEFINE SCOPE {{ scope }};
{% endif %}
-- Set the name of the token
DEFINE TOKEN {{ token_name }}
  -- Use this OAuth provider for {{ level|lower }} authorization
  ON {{ level }} {% if level == 'SCOPE' %}{{ scope }}{% endif %}
  -- Specify the cryptographic signature algorithm used to sign the token
  TYPE {{ token_type }}
  -- Specify the public key so we can verify the authenticity of the token
  VALUE "{{ token_value }}"
;
{% endmacro %}

-- DEFINE SCOPE
{% macro surreal__define_scope(scope_name, session_duration, signup_expression, signin_expression) -%}
DEFINE SCOPE {{ scope_name }} SESSION {{ session_duration }}
  SIGNUP ( {{ signup_expression }} )
  SIGNIN ( {{ signin_expression }} )
{% endmacro %}

-- DEFINE TABLE
{% macro surreal__define_table(table_name, options, schema, projections, tables, condition, groups, permissions) -%}
DEFINE TABLE {{ table_name }}
    {{ options }}
    {{ schema }}
    {{ projections }}
    FROM {{ tables }}
    {{ condition }}
    {{ groups }}
    {{ permissions }}
{% endmacro %}

-- DEFINE EVENT
{% macro surreal__define_event(event_name, table_name, expression_when, expression_then) -%}
DEFINE EVENT {{ event_name }} ON TABLE {{ table_name }} WHEN {{ expression_when }} THEN (
    {{ expression_then }}
);
{% endmacro %}

-- DEFINE FUNCTION
{% macro surreal__define_function(function_name, arguments, query, returned) -%}
DEFINE FUNCTION fn::{{ function_name }}(
    {{ arguments|join(', ') }}
) {
    {{ query }}
    RETURN {{ returned }};
}
{% endmacro %}

-- DEFINE FIELD
{% macro surreal__define_field(field_name, table_name, field_options) -%}
DEFINE FIELD {{ field_name }} ON TABLE {{ table_name }}
    {{ field_options|join('\n    ') }}
;
{% endmacro %}

-- DEFINE INDEX
{% macro surreal__define_index(index_name, table_name, index_options) -%}
DEFINE INDEX {{ index_name }} ON TABLE {{ table_name }}
    {{ index_options|join(' ') }}
;
{% endmacro %}

--DEFINE PARAM
{% macro surreal__define_param(param_name, param_value) -%}
DEFINE PARAM ${{ param_name }} VALUE {{ param_value }};
{% endmacro %}

