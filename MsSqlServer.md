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

## Move Database-Files

Copied from [Mike Fal](https://dba.stackexchange.com/a/52010) and [Dewi Rees' Comment](https://dba.stackexchange.com/questions/52007/how-do-i-move-sql-server-database-files#comment191126_52010)

1. Copy Files to new Destination
2. Run these Scripts
```SQL
USE master; --do this all from the master
ALTER DATABASE DATABASE_NAME
MODIFY FILE (name='DATABASE_FILE_NAME', filename='D:\<destination>'); --Filename is new location

USE master; --do this all from the master
ALTER DATABASE DATABASE_NAME
MODIFY FILE (name='DATABASE_LOG_FILE_NAME', filename='D:\<destination for log>');
```
3. Put the database offline, then online again.
4. You may delete the old files now

## Delete all rows in a table (in large tables)

[Documentation](https://docs.microsoft.com/en-us/sql/t-sql/statements/truncate-table-transact-sql)

```SQL
TRUNCATE TABLE <table>
```

## Create DateTime from German format

```SQL
CONVERT(datetime, '25.12.2017', 104)
```
