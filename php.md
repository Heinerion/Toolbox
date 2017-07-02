# PHP
## Regex for `preg_match` & `preg_replace`

### Remove all empty lines from file
```php
preg_replace ( ' /^\s*$/ ' ,   '' ,   $file);
```

### Remove all sinlge line comments from file
```php
preg_replace ( ' /^#.*$/ ' ,   '' ,   $file);
```

### Remove folders from absolute paths and keep only the file name
```php
preg_replace ( ' /^.*\// ' ,   '' ,   $path);
```

### Check for a 5 digit postal code
```php
preg_match ( ' /^\d{5}$/ ' ,   $field);
```

### Simple email check
```php
preg_match ( ' /^\S+@\S+\.[A-Z]{2,6}$/i ' ,   $field);
```

### Check 3 or 6 digit html hex colors
```php
preg_match ('/^#[0-9A-F]{3}([0-9A-F]{3})?$/i',   $color);
```
