with dim_listings_cleansed AS (
    SELECT 
        * 
    FROM 
        {{ ref('dim_listings_cleansed') }} 
)
SELECT 
    *
FROM 
    dim_listings_cleansed AS l
INNER JOIN 
    {{ ref('fct_reviews') }} r
USING 
    (listing_id)
WHERE 
    l.created_at >= r.review_date