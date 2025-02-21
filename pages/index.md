---
title: Parking Garage
description: Current occupancy of parking garages in various cities in Europe
---

```sql cities
SELECT city, city_url AS link_to_api, '/city/' || city as link
FROM cities;
```

Looking for a parking spot in your city but don’t want to waste time driving around? With Parking Garage, you can check real-time occupancy of parking garages in many cities! 🔍📊 Find the best spot and park stress-free. Data from these cities is available via the [PakenDD-API](https://parkendd.de/index.html). Select a row to see detailed data for that city:


<DataTable data={cities} link=link search=true rows=all/>

Please be aware that data is not available for all cities (e.g. Aachen). It is also possible that the available data is not up to date. For this reason, it is always indicated when the data was last downloaded and updated. 

