SELECT COUNT(travel_id) as "citizens"
, SUM(qty_countries) as "country_count"
, SUM(CASE WHEN qty_countries >= 5 THEN 1 END) as "qty_countries_5plus"
, SUM(CASE WHEN qty_countries = 4 THEN 1 END) as "qty_countries_4"
, SUM(CASE WHEN qty_countries = 3 THEN 1 END) as "qty_countries_3"
, SUM(CASE WHEN qty_countries = 2 THEN 1 END) as "qty_countries_2"
, SUM(CASE WHEN qty_countries = 1 THEN 1 END) as "qty_countries_1"
FROM
  (SELECT
  citizen_id
  , COUNT(DISTINCT(country_name)) as "qty_countries"
  FROM travelhistory
  WHERE date::date >= '2020-01-01'
  AND citizen_id LIKE '%_%'
  GROUP BY 1
  ORDER BY 2 DESC)
