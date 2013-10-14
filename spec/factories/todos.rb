# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :todo do
    member nil
    task nil
    year 1
    month 3
    week 23
    day 1
    family nil
    is_completed false
  end
end
