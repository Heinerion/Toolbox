# Windows command line

## check ports


check multiple ports:

```batch
netstat -na | findstr "\<9090\> \<3030\> \<80\> \<8443\> \<443\> \<8080\>"
```

## Open startup folder (not quite command line)

as answered by <https://superuser.com/a/954957>

[Windows] + [R], then type `shell:startup`
