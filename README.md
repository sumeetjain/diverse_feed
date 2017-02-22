# Diverse Feed

Collecting demographic information about people, so we can generate diversity reports for the people anyone follows on Twitter (for example).

## Setup

Assuming you have the Ruby version indicated in **/ruby-version**, just run these commands from the project's root folder:

```
bin/setup
gem install foreman
```

## Running

To run the app, you can run `rails s`, as usual.

If you need for other processes besides the web server to be running, you will also want to run `foreman start -f Procfile.development` in another terminal tab/window/screen.

**Currently there is nothing in _/Procfile.development_, so there is no point to starting Foreman.** But if processes (like a jobs queue) get added to the application, those will require Foreman to be run. Expect an update to this README (and some additional communication!) at that point.