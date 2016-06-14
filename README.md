# catstagram
Simple Cat version of Instragram in Ruby on Rails - for Webrails class at HEIG-VD

## Context and Authors
This is a Ruby on Rails project for WebRails class at HEIG-VD, Yverdon-les-Bains, Switzerland.

Authors:

 - [Eleonore d'Agostino](http://github.com/paranoodle)
 - [Valentin Minder](http://github.com/ValentinMinder)

## Installation

As a prerequisite, you need `ruby`, `rails`, `mysql` and `imagemagick`. `imagemagick` may install itself if you have `apt-get` (linux) or `brew` (macosx).

You can launch in 1-click [using the script](#installation-using-the-script) or do it [manually](#manual-nstallation).

When you're done, you can reach the website on

[localhost:3000](localhost:3000)

You can connect as an admin with 

```
email: admin@cat.com
login: admin1
```

Or you can connect as an user with

```
email: val@cat.com or paranoodle@cat.com
login: user12
```

### Installation using the script

Execute the given script `setup.sh`, that will do everything for you. It is still necessary to check database connection settings in `config/database.yml` if you don't run with default params.

- install imagemagick (supported are `apt-get` and `brew`)
- launch mysql
- drop & create the db in mysql
- execute the migration
- fill the db with the fixtures
- launch the server (type ctrl-c to escape)
- quit mysql

### Manual installation

Install `imagemagick` manually.

It is necessary to set up `mysql` with a database `catstagram` first, and to check database connection settings in `config/database.yml` (there are several example, like with `mysqld` or `MAMP`).

Then, execute the migrations

```
rake db:migrate
```

To populate the database with some example data, type:

```
rake db:fixtures:load
```

**To launch, simply type** :

```
rails s
```

If you need more details, check [here](specs_report) the complete documentation, under ***Installation Indications*** section (at the end).

## Final Report

The final report, with full documentation and usage manual, is available [here](specs_report)

## Slides of the presentation
***In french***, available [here](specs_report/slides.pdf)

## Useful commands

For the records, the commands we used, in sequential order.

```
rails new Catstagram -d mysql

rails g scaffold User username:string avatar_url:string biography:text banned_until:datetime
rails g scaffold Cat catname:string description:text city:string birth_time:date
rails g scaffold Photo image_url:string caption:text view_count:integer like_count:integer report_count:integer
rails g scaffold Hashtag tag:string

rails g migration CreateJoinTablePhotoCat photo cat
rails g migration CreateJoinTablePhotoHashtag photo hashtag

rails g migration AddUserToPhotos user:references
rails g migration AddUserToCats user:references

rails g uploader Image

rails generate devise:install
# to copy devise views to be customisable
rails g devise:views
# to add devise fields to existing model User
rails generate devise User

# roles
rails generate scaffold Role name:string
rails generate migration RolesUsers

# cancan
rails g cancan:ability

#to populate the db with some fixtures
rake db:fixtures:load
```