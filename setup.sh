#!/bin/sh

# install imagemagick (supported are `apt-get` and `brew`)
# linux (requires sudo password)
sudo apt-get install imagemagick
# macosx
brew install imagemagick

# if mysqld/mysqladmin doesnt work, comment it out, lanch mysql from MAMP and use the following command instead
# according to http://www.manpagez.com/man/1/mysql/
# check your usernmae and socket --socket /tmp/mysql.sock or /Applications/MAMP/tmp/mysql/mysql.sock 
# mysql --host=localhost --port=8889 --user=root --socket /Applications/MAMP/tmp/mysql/mysql.sock --password=root -e "drop database Catstagram; create database Catstagram"

# launch mysql (on localhost / 3306 / root / ''/ using socket on /tmp/mysql.sock), drop & create database
mysqld &
mysqladmin -u root drop database Catstagram
mysqladmin -u root create database Catstagram

# create the db in mysql

cd Catstagram

# execute the migration
rake db:migrate

# fill the db with the fixtures
rake db:fixtures:load

#launch the server
rails s

# stop mysql
mysqladmin -u root shutdown
