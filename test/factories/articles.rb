# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :article do
    title "MyString"
    category "MyString"
    date "2012-08-31"
    tags "MyString"
    published false
    source "MyText"
    content "MyText"
  end
end
