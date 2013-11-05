# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  
config.before(:all) do 

    @family =  FactoryGirl.create(:family, {name: "test fam"})
    @cat1 =    FactoryGirl.create(:category, {name: "monthly"})
    @cat2 =    FactoryGirl.create(:category, {name: "weekly"})
    
    @i_m =     FactoryGirl.create(:interval, {name: "Monthly"})
    @i_w =     FactoryGirl.create(:interval, {name: "Weekly"})
    @i_d =     FactoryGirl.create(:interval, {name: "Daily"})

    @task1 =   FactoryGirl.create(:task, {name: "monthly task", interval_id: @i_m.id, category_id: @cat1.id})
    @task2 =   FactoryGirl.create(:task, {name: "first weekly task", interval_id: @i_w.id, category_id: @cat2.id})
    @task3 =   FactoryGirl.create(:task, {name: "second weekly task", interval_id: @i_w.id, category_id: @cat2.id})
    @task4 =   FactoryGirl.create(:task, {name: "daily task", interval_id: @i_d.id, category_id: @cat2.id})
  end

  config.after(:all) do
    @cat1.destroy
    @cat2.destroy

    @i_m.destroy
    @i_w.destroy
    @i_d.destroy

    @task1.destroy
    @task2.destroy
    @task3.destroy
    @task4.destroy

    @family.destroy

  end

  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"
end
