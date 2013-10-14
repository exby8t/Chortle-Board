# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :member do
    first_name "MyString"
    last_name "MyString"
    email "MyString"
    password "MyString"
    birthdate "2013-10-13"
    family nil
    member_type nil
  end
end
