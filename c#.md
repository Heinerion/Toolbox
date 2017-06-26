# C#

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
