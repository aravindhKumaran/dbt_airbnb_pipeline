WITH dim_listings_cleansed AS (
    SELECT 
        *
    FROM
        {{ ref('dim_listings_cleansed') }}
)
SELECT 
    * 
FROM 
    dim_listings_cleansed
WHERE 
    minimum_nights < 1
