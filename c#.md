# C#

## Entity Framework

Eagerly load properties

```c#
using System.Data.Entity;

/* ... */

return context
      .collection
      .Include(x => x.listProperty.Select(item => item.anotherReference))
      .Where(/* ... */)
      .ToList();
```
