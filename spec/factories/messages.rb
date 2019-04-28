FactoryBot.define do

  factory :message do
    message { Faker::Lorem.sentence }
    image   { File.open("#{Rails.root}/public/uploads/message/image/16/icon_03.png") }
    user
    group
  end

end
