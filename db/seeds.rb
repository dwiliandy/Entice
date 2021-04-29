# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'
a = CSV.read("regencies.csv")
User.create(email: 'admin@admin.com', password:'password', address:'asd', name: 'admin', phone_number: '08191940123', role: 1)
User.create(email: 'cs@cs.com', password:'password', address:'asdasd', name: 'cust', phone_number: '08191940121', role: 0)

a.each {|regencies| Region.create(name: regencies.last)}