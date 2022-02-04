FactoryBot.define do
    factory :post do
      title { 'title 1' }
      description { 'some content' }
      image {Rack::Test::UploadedFile.new('/home/dinesh/Desktop/Ruby/1/public/5.jpg', 'image/jpg')}
      user_id { FactoryBot.build(:user).id }
    end
  end