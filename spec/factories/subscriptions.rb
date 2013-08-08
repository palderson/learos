# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :subscription do
    stripe_customer_token "MyString"
    expire_date "2013-08-03"
    user nil
  end
end
