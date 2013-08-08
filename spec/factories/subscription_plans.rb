# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :subscription_plan do
    name "MyString"
    price "9.99"
    number_of_projects 1
  end
end
