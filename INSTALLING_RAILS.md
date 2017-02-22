# Installing Rails

This goes over the steps I took to set up this app, from the very first initialization of the Rails codebase.

First, I checked that I liked the version of Rails I was on. `rails -v` told me it was version 4.2.7.1, which is the latest version indicated at <http://guides.rubyonrails.org/v4.2/>. Then I generated the codebase:

`rails new diverse-feed -d postgresql --skip-spring --skip-turbolinks --skip-test-unit`

This made a new folder **diverse-feed/** and dumped all of Rails's files into it. I added flags to the command above for 1) setting the database adapter to use Postgres instead of SQLite (since Heroku uses Postgres, and I want environment parity), 2) Skip Spring (It's caused debugging headaches before), 3) Skip Turbolinks (I never grew to like them), and 4) Skip TestUnit (since I'll be installed rspec later).

Then I `cd`'d into the project folder and ran `git init`, created this very file, and committed everything.

---

Then I set Puma as the web server, instead of the default Webrick. This is because Heroku recommends it: <https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server>

---

I ran into a slight issue because my Ruby version was 2.4, but Rails 4.2 doesn't support that new of a Ruby. So I switched Ruby back to 2.3, which solved my problems. I added a **.ruby-version** file, so everyone else will know what version of Ruby this application expects you to run.

---

The next thing I did was check that Puma and Foreman play nicely with Pry. I depend on Pry a lot, and I don't want to delay making my application's groundwork compatible with it.

Foreman is inherently incompatible with Pry, however. So I figured out the best (in my opinion) workaround and wrote up a bit about how devs should run the application locally. That writeup is in the main [README.md](./README.md) file.

---

The next thing I set up was rspec, for testing, since I'd removed TestUnit before.