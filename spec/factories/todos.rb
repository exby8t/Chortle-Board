# Read about factories at https://github.com/thoughtbot/factory_girl
require 'date'
FactoryGirl.define do
  factory :todo do
    member nil
    task nil
    year Date.today.year
    month Date.today.month
    week Date.today.cweek
    day Date.today.mday
    family nil
    is_completed false
  end
end
