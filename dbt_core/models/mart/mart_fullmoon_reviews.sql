WITH fct_reviews AS (
    SELECT
        *
    FROM 
        {{ ref('fct_reviews') }}
),
full_moon_dates AS (
    SELECT  
        *
    FROM
        {{ ref('seed_full_moon_dates') }}
)

SELECT
    fr.*,
    CASE WHEN fm.full_moon_date IS NULL THEN 'not full moon' ELSE 'full_moon' END AS is_full_moon
FROM 
    fct_reviews fr 
    LEFT JOIN full_moon_dates fm 
    ON TO_DATE(fr.review_date) = fm.full_moon_date 