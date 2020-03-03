require('pry-byebug')
require_relative('models/property.rb')

property1 = Property.new({'address' => '10 High Street', 'year_built' => 1995, 'buy_let_status' => 'buy', 'square_footage' => 1400})

property2 = Property.new({'address' => '30 High Street', 'year_built' => 2000, 'buy_let_status' => 'let', 'square_footage' => 1200})


property1.save
property2.save

property2.year_built = 2002
property2.update
# property1.delete

Property.find_by_address

binding.pry
nil
