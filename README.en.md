# Maracay's Alliance Française

This is a web application designed for Maracay's Alliance Française as part of my thesis to opt for
the Information Engineering degree at Universidad Tecnológica del Centro (UNITEC) with the aim to manage the institute's administrative tasks in an efficient, quick way.

Made with ♥ by Angel Perez, from Venezuela.

[Español](./README.md) | [Français](./README.fr.md)

# Stack

This app was built under the following stack:
* [Sinatra](http://www.sinatrarb.com/)
* [MariaDB](https://mariadb.org/)
* [ActiveRecord](http://guides.rubyonrails.org/active_record_basics.html) + [Sinatra ActiveRecord](https://github.com/janko-m/sinatra-activerecord)
* [Bootstrap](http://getbootstrap.com/)

# Setup
* Fork this repo
* On your environment, add 3 variables for MariaDB's username, password and database.
* Also, add this to your environment as well:

``` shell
mysql2://{username}:{password}@{host}/{database}
```

* Go to the project's folder
* On /config, create a 'database.yml' file, and add the following:

``` yaml
development:
  adapter: mysql2
  encoding: utf8
  reconnect: false
  database: <%= ENV['your_variable'] %>
  pool: 5
  username: <%= ENV['your_variable'] %>
  password: <%= ENV['your_variable'] %>
  socket: /var/run/mysqld/mysqld.sock
  host: localhost
```

* Make sure you have the following packages installed:

``` shell
mariadb-server libmariadbclient-dev
```

Otherwise, install them before procedding.

* Make sure Bundler is installed. Then, run the following command:

``` shell
bundle install
```

* Now create the database, load the schema and seed it:

``` shell
rake db:setup
```

* Finally, start the app:

``` shell
ruby app.rb
```

You can start using the app at http://localhost:4567/sigin with the following credentials:
* ID: 123456
* Password: 123

# Usage
This web application lets you:
* Create, modify and delete users (Admins)
* Password change
* Students' signups and fees management
* Students' management and their grades
* Courses' management
* Teachers' management and their work hours
* Wages' management (Admins)
* Storage management
* Report generation (Admins)

This app can be used in other Alliance Française offices where an administrative system is required or on institutions with similar needs.

# Contributing
* Fork this repo
* Add the feature or bugfix you worked on
* Don't forget to add tests, so I can make sure everything works as expected
* Commit!
* Send me a pull request

# License
[AGPL](./LICENSE) ♥

# Social
You can follow me on Twitter as [@AITBW](https://twitter.com/AITBW)
