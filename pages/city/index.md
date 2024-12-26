---
title: City
queries:
   - city: city.sql
---

Click on an item to see more detail


```sql city_with_link
select *, '/city/' || city as link
from ${city}
```

<DataTable data={city_with_link} link=link search=true rows=all/>
