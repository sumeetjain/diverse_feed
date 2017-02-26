# Diverse Feed

Collecting demographic information about people, so we can generate diversity reports for the people anyone follows on Twitter (for example).

## Setup

Assuming you have the Ruby version indicated in **/.ruby-version**, just run these commands from the project's root folder:

```
bin/setup
gem install foreman
```

### Services

Go to <https://apps.twitter.com/app/new> and create a new app on Twitter. Set `http://127.0.0.1:3000/auth/twitter/callback` as the callback URL.

### Set ENV Variables

Copy **.env** to **.env.local**. This is where you should add the tokens/keys you just got from setting up the new Twitter app.

## Running

To run the app, you can run `rails s`, as usual.

If you need for other processes besides the web server to be running, you will also want to run `foreman start -f Procfile.development` in another terminal tab/window/screen.

**Currently there is nothing in _/Procfile.development_, so there is no point to starting Foreman.** But if processes (like a jobs queue) get added to the application, those will require Foreman to be run. Expect an update to this README (and some additional communication!) at that point.

## App Structure

### app/models/

Standard models, inheriting from `ActiveRecord::Base` and tied to some table in the database.

### app/services/

Single-responsibility classes of business logic. This is also where third-party service wrappers go, like `TwitterService`.

### specs/

Specs follow the same directory structure as **app/**.

#### specs/support/

This is specifically for files whose sole purpose in life is to help make the tests run.