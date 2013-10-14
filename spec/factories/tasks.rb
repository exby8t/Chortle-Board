# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :task do
    name "Test Task"
    points 10
    interval nil
    category nil
    age_limit nil
    is_active true
  end
end
