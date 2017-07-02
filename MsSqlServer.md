# MS SQL Server

## Determine SQL Server version from `.bak` file

```SQL
RESTORE HEADERONLY FROM DISK = 'X:\Path\to.bak'
```

Interesting fields in result:

    DatabaseVersion, SoftwareVersionMajor, SoftwareVersionMinor, SoftwareVersionBuild

The DatabaseVersion translates to (according to [Wikipedia](https://en.wikipedia.org/wiki/History_of_Microsoft_SQL_Server))

|DatabaseVersion|Major|Minor|Name|
|---------------|----|----|----|
|661|10|0|SQL Server 2008|
|?|10|25|Azure SQL database (initial release)|
|665|10|50|SQL Server 2008 R2|
|706|11|0 |SQL Server 2012|
|782|12|0 |SQL Server 2014|
|852|13|0 |SQL Server 2016|
|?|14|0 |SQL Server 2017|

: MS SQL Database versions
