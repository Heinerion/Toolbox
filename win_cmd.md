# Windows command line

## check ports


check multiple ports:

```batch
netstat -na | findstr "\<9090\> \<3030\> \<80\> \<8443\> \<443\> \<8080\>"
```
