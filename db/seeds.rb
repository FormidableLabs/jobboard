# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Category.create([ { name: 'Design' }, { name: 'Programming' }, 
                  { name: 'Business/Exec' }, { name: 'System Administrator' }, 
                  { name: 'Copywriter' }, { name: 'Custom Service/Support' }, 
                  { name: 'Miscellaneous' }])