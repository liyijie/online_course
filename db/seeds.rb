# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
begin
	User.create!({phone: '13006201800',username: 'dtby', role: 1, password: 'dtby123456', password_confirmation: 'dtby123456'})
rescue Exception => e
	pp e.message + ' User'
end