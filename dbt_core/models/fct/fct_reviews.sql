{{
    config(
        materialized = 'incremental',
        on_schema_change = 'fail'
    )
}}


WITH src_reviews AS (
    SELECT
        *
    FROM 
        {{ ref('src_reviews') }}
)
SELECT 
    {{ dbt_utils.generate_surrogate_key(['listing_id', 'review_date', 'reviewer_name', 'review_text']) }} AS review_id -- from 3rd party package
    ,*
FROM 
    src_reviews
WHERE 
    review_text IS NOT NULL


{% if is_incremental() %}
    {% if var("start_date", False) and var("end_date", False) %}
        {{ log('Loading ' ~ this ~ ' incrementally (start_date: ' ~ var("start_date") ~ ', end_date: ' ~ var("end_date") ~ ')', info=True) }}
        AND review_date >= '{{ var("start_date") }}'
        AND review_date < '{{ var("end_date") }}'
    {% else %}
        AND review_date > ( SELECT MAX(review_date) FROM {{ this }} )
        {{ log('Loading ' ~ this ~ ' incrementally (all missing dates)', info=True) }}
    {% endif %}
{% endif %}


-- pass start_date and end_date in terminal using this command
-- dbt run -s fct_reviews --vars "{start_date: 2024-02-15 00:00:00, end_date: 2024-03-15 23:59:59}"