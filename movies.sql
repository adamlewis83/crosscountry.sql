--This query groups box office performance by genre by month

SELECT
CAST(date_trunc('month', release_date) as date) as month,
CASE 
  WHEN lower(studio) = 'pixar' OR lower(studio) = 'dreamworks' THEN 'animation'
  WHEN lower(title) LIKE 'star wars%' OR lower(title) LIKE 'star trek%' THEN 'sci-fi'
  WHEN lower(director) = 'rob zombie' OR lower(director) = 'eli roth' THEN 'horror'
  WHEN lower(star) = 'dwayne johnson' OR lower(star) = 'jet li' THEN 'action'
  ELSE 'other' END as "genre",
COUNT(DISTINCT(customer_id)) as "customers",
COUNT(DISTINCT(ticket_id)) as "tickets",
COUNT(DISTINCT(movie_id)) as "movies",
SUM(CASE WHEN lower(membership_type) IN ('active') THEN ticket_sales END) as "sales_members"
SUM(CASE WHEN lower(membership_type) NOT IN ('active') THEN ticket_sales END) as "sales_nonmembers"
SUM(ticket_sales) as "sales_total"
FROM boxoffice
WHERE release_date::date >= '2020-01-01'
AND customer_id LIKE '%_%'
GROUP BY month, genre
ORDER BY month;
