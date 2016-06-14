# catstagram
Simple Cat version of Instragram in Ruby on Rails - for Webrails class at HEIG-VD

## Context and Authors
This is a Ruby on Rails project for WebRails class at HEIG-VD, Yverdon-les-Bains, Switzerland.

Authors:

 - [Eleonore d'Agostino](http://github.com/paranoodle)
 - [Valentin Minder](http://github.com/ValentinMinder)

## Installation

You need `ruby`, `rails`, `mysql` and `imagemagick`.

It is necessary to set up `mysql` with a database `catstagram` first, and to check database connection settings in `config/database.yml`.

To launch, simply type: 

```
rails s
```

To populate the database with some example data, type:

```
rake db:fixtures:load
```

If you need more details, check [here](specs_report#Installation Indications)


## Final Report

Available [here](specs_report)
