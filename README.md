# Diverse Feed

Collecting demographic information about people, so we can generate diversity reports for the people anyone follows on Twitter (for example).

---

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

---

## Running

To run the app, you can run `rails s`, as usual.

If you need for other processes besides the web server to be running, you will also want to run `foreman start -f Procfile.development` in another terminal tab/window/screen.

**Currently there is nothing in _/Procfile.development_, so there is no point to starting Foreman.** But if processes (like a jobs queue) get added to the application, those will require Foreman to be run. Expect an update to this README (and some additional communication!) at that point.

---

## App Structure

### app/models/

Standard models, inheriting from `ActiveRecord::Base` and tied to some table in the database.

### app/services/

Single-responsibility classes of business logic. This is also where third-party service wrappers go, like `TwitterService`.

### specs/

Specs follow the same directory structure as **app/**.

#### specs/support/

This is specifically for files whose sole purpose in life is to help make the tests run.

---

## User Interface (assets, design, etc.)

### Grid

We're using _Neat_: <http://neat.bourbon.io/docs/latest/>

This is a minimal, easy-to-understand CSS grid framework. It doesn't create any CSS classes (like `.column` or `.column-6`). Instead, it creates modules in SASS for you to `@include` inside your own CSS.

Example:

```scss
.container{
  @include grid-container;
  width: 960px;
  margin: 0 auto;
}
```

That will generate:

```css
.container{
  width: 960px;
  margin: 0 auto;
}
.container::after{
  clear: both;
  content: "";
  display: block;
}
```

_Neat_ only creates a handful of essential modules. It'll take all of 5 minutes to read the entire set of docs at the link above. Each section of the docs shows the module and also the exact CSS that it will generate.

#### How to contribute to this site's front-end:

Don't overthink it. Much of the time, you won't need to worry about the grid at all. If you're just adding a couple elements which happen to be side-by-side, find a way to accomplish that with whatever CSS makes the most sense to you (flexbox, floats, etc).

If you do end up needing to add something which should fit within the grid, your HTML should look something like this:

```html
<div class="sectionName">
  <div class="container">
    <p>Section's contents go here.</p>
  </div>
</div>
```

Within the section's container, define elements with classes as needed and include the relevant grid module on that class in CSS. E.g. if you have two elements that should fit _3 + 9_ into the grid, you'd end up with CSS like this:

```scss
.elementOne{
  @include grid-column(3);
}
.elementTwo{
  @include grid-column(9);
}
```

You can add any additional styling to containers as well as columns:

```scss
.elementOne{
  @include grid-column(3);
  background-color: #ccc;
}
.elementTwo{
  @include grid-column(9);
  border-bottom: 2px solid #218902;
  background-color: #0E3001;
}
```

### CSS Guidelines

- Avoid IDs, except where needed for on-page anchor links
- Separate layout vs. formatting concerns into different styles
- Avoid depending on impermanent HTML tags/ordering/structure in CSS selectors (e.g. `.title a` is probably okay, but `ul div` or `h4 a` are too prone to change)
- Avoid CSS cleverness. If you find yourself hunting for an obscure selector, consider whether the CSS would be more maintainable if you just added a class that expressed your intention instead.
- Use `camelCase` for CSS classes.
- Use `--` to indicate a [modifier class](http://getbem.com/naming/), e.g. `.nav--current` modifies `.nav`.

### JavaScript Guidelines

- Never select elements using a class which might have CSS applied to it.
  + To guarantee this, add a new class to elements you want to select. Prefix that class with `js-` (e.g. `js-navLink` is a new class you might add to an element that already has the `navLink` class). Then just do `document.getElementsByClassName("js-navLink")`.
- Never define styles for a class beginning with `js-` in a stylesheet.
