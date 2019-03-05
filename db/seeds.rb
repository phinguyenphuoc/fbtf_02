# fake user
User.create!(name: "Tran Le Thanh Dat",
             email: "tranlethanhdat@gmail.com",
             phonenumber: 193456789,
             password: "123456",
             password_confirmation: "123456",
             role: 1)
10.times do |n|
  email = Faker::Internet.email
  phonenumber = Faker::Number.number(10)
  User.create!(name: "Dat Tran Le Thanh",
               email: email,
               phonenumber: phonenumber,
               password: "123456",
               password_confirmation: "123456")
end
# create category
Category.create!(name: "domestic")
Category.create!(name: "foreign")
# create location
Location.create!(name: "Da Nang")
Location.create!(name: "Sai Gon")
Location.create!(name: "Ha Noi")
4.times do |n|
  location = Faker::Nation.capital_city
  Location.create!(name: location)
end
# create travelling
Travelling.create!(location_start_id: 1,
                   location_end_id: 2)
Travelling.create!(location_start_id: 2,
                   location_end_id: 3)
Travelling.create!(location_start_id: 4,
                   location_end_id: 5)
# create tour
2.times do |n|
  price = Faker::Number.number(7)
  time_start = Faker::Time.between(DateTime.now - 20, DateTime.now - 1)
  time_end = Faker::Time.between(DateTime.now, DateTime.now + 1)
  max_quantity = Faker::Number.number(2)
Tour.create!(category_id: 1,
             travelling_id: n+1,
             price: price,
             time_start: time_start,
             time_end: time_end,
             title: "Du Lich Trong Nuoc",
             max_quantity: max_quantity)
end
2.times do |n|
  price = Faker::Number.number(8)
  time_start = Faker::Time.between(DateTime.now - 20, DateTime.now - 1)
  time_end = Faker::Time.between(DateTime.now, DateTime.now + 1)
  max_quantity = Faker::Number.number(2)
Tour.create!(category_id: 2,
             travelling_id: n+3,
             price: price,
             time_start: time_start,
             time_end: time_end,
             title: "Du Lich Quoc Te",
             max_quantity: max_quantity)
end
