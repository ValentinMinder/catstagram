# catstagram
Simple Cat version of Instragram in Ruby on Rails - for Webrails class at HEIG-VD

## Context and Authors
This is a Ruby on Rails project for WebRails class at HEIG-VD, Yverdon-les-Bains, Switzerland.

Authors:

 - [Eleonore d'Agostino](http://github.com/paranoodle)
 - [Valentin Minder](http://github.com/ValentinMinder)

## Installation

### Prerequesites

You need on your system

- `ruby` (tested with 2.2.3p173)
- `rails` (tested with 4.2.5.1)
- `mysql`
- `imagemagick`. It comes by default on most linux distribution, otherwise use your favorite packet manager ton get it, like un Linux `sudo apt-get install imagemagick` or on MacOS X `brew install imagemagick`

### Configuration

- Create a table named `Catstagram` in your mysql editor.
- Run mysql
- Move to the project directory: `cd Catstagram`
- Update the database config (host, user, password) of the file `Catstagram/config/database.yml` using your favorite editor (`nano`, `vim`, etc)
- Run the following command to install & update bundles: `bundle install; bundle update`
- Run the server: `rails s`

## Provisional Report

Available [here](specs_report)
