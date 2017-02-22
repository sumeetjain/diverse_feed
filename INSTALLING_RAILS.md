# Installing Rails

This goes over the steps I took to set up this app, from the very first initialization of the Rails codebase.

First, I checked that I liked the version of Rails I was on. `rails -v` told me it was version 4.2.7.1, which is the latest version indicated at <http://guides.rubyonrails.org/v4.2/>. Then I generated the codebase:

`rails new diverse-feed -d postgresql --skip-spring --skip-turbolinks --skip-test-unit`

This made a new folder **diverse-feed/** and dumped all of Rails's files into it. I added flags to the command above for 1) setting the database adapter to use Postgres instead of SQLite (since Heroku uses Postgres, and I want environment parity), 2) Skip Spring (It's caused debugging headaches before), 3) Skip Turbolinks (I never grew to like them), and 4) Skip TestUnit (since I'll be installed rspec later).

Then I `cd`'d into the project folder and ran `git init`, created this very file, and committed everything.

---

