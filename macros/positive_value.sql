-- This generic test can be called in .yml file and the column name and model will be filled automatically

{% test positive_value(model, column_name) %}
    SELECT 
        * 
    FROM 
        {{ model }}
    WHERE 
        {{ column_name }} < 1
{% endtest %}