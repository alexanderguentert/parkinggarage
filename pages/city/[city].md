---
queries:
   - city: city.sql
---

# {params.city}


```select_city_url
select city_url from ${city} where city = '${params.city}'
```
<Dropdown
    name=selected_item
    data={select_city_url}
    value=city_url
/>

```one_city
-- download data for selected city
WITH one_city_json AS (
  SELECT 
    STRPTIME(last_downloaded,'%Y-%m-%dT%H:%M:%S') AS last_downloaded,
    STRPTIME(last_updated,'%Y-%m-%dT%H:%M:%S') AS last_updated,
    UNNEST(lots) city_json 
  FROM 
    read_json('${inputs.selected_item.value}')
)
SELECT 
  last_downloaded,
  last_updated,
  city_json.address,
  city_json.coords.lat,
  city_json.coords.lng,
  city_json.forecast,
  city_json.free,
  city_json.id,
  city_json.lot_type,
  city_json.name,
  city_json.state,
  city_json.total,
  city_json.free/city_json.total AS percent_free
FROM 
  one_city_json;
```
Selected data for {params.city}.

Last Downloaded:  <Value data={one_city} column=last_downloaded fmt='yyyy-m-d HH:MM:SS' />

Last Updated:  <Value data={one_city} column=last_updated fmt='yyyy-m-d HH:MM:SS' />


<BubbleMap 
    data={one_city.where(`lat IS NOT NULL AND lng IS NOT NULL AND percent_free IS NOT NULL`)} 
    title="Location of parking garages"
    lat=lat 
    long=lng
    size=total 
    value=percent_free
    valueFmt=pct
    pointName=name 
/>

The size of the bubbles shows how many parking spaces are available in total. The color shows the occupancy rate as a percentage.

<DataTable data={one_city} search=true>
  <Column id=name/> 
  <Column id=state/> 
  <Column id=free/>
  <Column id=total/>
  <Column id=percent_free fmt=pct contentType=bar/>
  <Column id=address/> 
  <Column id=forecast/>
</DataTable>

<BarChart 
    data={one_city}
    title="Percentage and absolute number of free parking lots"
    x=name
    y=percent_free
    y2=free
    yFmt=pct
    type=grouped
    swapXY=false
/>