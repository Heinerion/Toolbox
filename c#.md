# C\#

## General

### Parse DateTime form String regardless of Culture

```c#
private static DateTime parseExact(String dateString)
{
    return DateTime.ParseExact(dateString, "dd-MM-yyyy", CultureInfo.InvariantCulture);
}
```

### Calculate folder size

Using DirectoryInfo instead of Directory

```c#
public Int64 getDirectorySize(String path)
{
    Int64 sum = 0;
    DirectoryInfo directoryInfo = new DirectoryInfo(path);

    if (directoryInfo.Exists)
    {
        foreach (FileInfo info in directoryInfo.GetFiles("*.*", SearchOption.AllDirectories))
            sum += info.Length;
        return sum;
    }
    
    // throw exception or something
}
```

### Display bytes in the most appropriate Unit

Taken from https://stackoverflow.com/a/14488941 

```c#
static readonly string[] SizeSuffixes = { "bytes", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB" };

public String sizeSuffix(Int64 value, Int32 decimalPlaces = 1)
{
    if (value < 0)
    {
        return "-" + sizeSuffix(-value);
    }
    if (value == 0)
    {
        return "0.0 bytes";
    }

    // mag is 0 for bytes, 1 for KB, 2, for MB, etc.
    Int32 mag = (Int32) Math.Log(value, 1024);

    // 1L << (mag * 10) == 2 ^ (10 * mag) 
    // [i.e. the number of bytes in the unit corresponding to mag]
    Decimal adjustedSize = (Decimal) value / (1L << (mag * 10));

    // make adjustment when the value is large enough that
    // it would round up to 1000 or more
    if (Math.Round(adjustedSize, decimalPlaces) >= 1000)
    {
        mag += 1;
        adjustedSize /= 1024;
    }

    return String.Format("{0:n" + decimalPlaces + "} {1}",
        adjustedSize,
        SizeSuffixes[mag]);
}
```

## Entity Framework

### Load properties eargerly

```c#
using System.Data.Entity;

/* ... */

return context
      .collection
      .Include(x => x.listProperty.Select(item => item.anotherReference))
      .Where(/* ... */)
      .ToList();
```

### Use a transaction

```c#
using (EntityFrameworkContext context = new EntityFrameworkContext())
{
    using (DbContextTransaction dbContextTransaction = context.Database.BeginTransaction())
    {
        try
        {
            /* Operations on context which may throw exceptions */

            context.SaveChanges();

            dbContextTransaction.Commit();
        }
        catch (Exception e)
        {
            dbContextTransaction.Rollback();

            /* Handle Exception or rethrow */
        }
    }
}
```
or as convenience method:
```c#
private void wrapInTransaction(Action databaseAccess)
{
    using (DbContextTransaction dbContextTransaction = context.Database.BeginTransaction())
    {
        try
        {
            databaseAccess();

            dbContextTransaction.Commit();
        }
        catch
        {
            dbContextTransaction.Rollback();
            throw;
        }
    }
}

/* ... */

wrapInTransaction(() => failableDatabaseStuff());

```

## ASP.NET

### transformed webconfig HTTP rewrite rule

as stated by [StuartQ on Stack Overflow](https://stackoverflow.com/a/20249885/3535608), tailored for my needs

```xml
<system.webServer>
  <rewrite xdt:Transform="Insert">
    <rules>
      <rule name="http to https" stopProcessing="true">
        <match url="(.*)" />
        <conditions>
          <add input="{HTTPS}" pattern="^OFF$" />
        </conditions>
        <action type="Redirect" url="https://{HTTP_HOST}/{R:1}" />
      </rule>
    </rules>
  </rewrite>
</system.webServer>
```
