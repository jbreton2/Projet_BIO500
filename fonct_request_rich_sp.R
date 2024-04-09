
request.rich <- "
  SELECT observations.site_id, lat, COUNT(DISTINCT(valid_scientific_name)) AS richesse_sp
  FROM observations
  INNER JOIN sites ON observations.site_id = sites.site_id
  GROUP BY sites.site_id
  ORDER BY lat ASC;"

rich.spec <- dbGetQuery(con,request.rich)
head(rich.spec)




