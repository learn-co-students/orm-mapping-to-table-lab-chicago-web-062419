require 'sqlite3'
require 'bundler'
Bundler.require

require_relative '../lib/student'

DB = {:conn => SQLite3::Database.new("db/students.db")}

#Your connection to the database can be referred to, throughout your program, like this: DB[:conn].
