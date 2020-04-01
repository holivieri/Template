## Template for Business Solution

### Includes

## Angular 8 front end

	This frontend application connects to the Web API to authenticate, register or create users.

## .NET Core 3.1 Backend (web Api)

This solution (updated to .net core 3.1) has two different environemnt
This app is going to use the port 5500, you can change it.

* Production
* Development

If we set the environment (Properties/launch.settings) to Development, the user info is saved in localDb.
If we set the environment to Production, is going to use a SQL Database (specified in the app.settings connection string)

This application authenticate the users and returns a Json Web Token (JWT)


## Testing
There are a few Postman examples (Testing-Postman) to test the Web API.

## Mobile
There is a mobile soluion, done with Google Flutter that can be used as template for creating mobile apps.
