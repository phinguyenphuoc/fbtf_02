require "csv"
namespace :import do
  desc "import users"
  task users: :environment do
    counter = 0
    filename = File.join Rails.root, "users.csv"
    CSV.foreach(filename) do |row|
      name, email, phonenumber, password = row
      user = User.create(name: name, email: email, phonenumber: phonenumber,
        password: password)
      puts "#{email} - #{user.errors.full_messages}" if user.errors.any?
      counter += 1 if user.persisted?
    end
    puts "#{I18n.t('imported')} #{counter} #{I18n.t('user')}"
  end
end
