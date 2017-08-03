# IIS - Internet Information Server

## Find application pool user to grant writing permissions to project folder

The user name consists of `IIS AppPool\` and the name of the app pool itself.

For instance, if the app pool is named `webApp` the complete user name would be `IIS AppPool\webApp`

**Important Note:** The search path needs to be the *machine*, not the AD or something.
