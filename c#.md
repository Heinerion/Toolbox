# C\#

## General

### Parse DateTime form String regardless of Culture

```c#
private static DateTime parseExact(String dateString)
{
    return DateTime.ParseExact(dateString, "dd-MM-yyyy", CultureInfo.InvariantCulture);
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

as stated by https://stackoverflow.com/a/20249885/3535608, tailored for my needs

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
