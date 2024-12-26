SELECT 
    UNNEST(json_keys(cities)) AS city, 
    'https://api.parkendd.de/'|| UNNEST(json_keys(cities)) AS city_url
FROM 
    read_json("https://api.parkendd.de/")