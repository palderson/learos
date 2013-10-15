# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :jira_integration do
    jira_site_url "MyString"
    jira_consumer_key "MyString"
    jira_private_key "MyString"
  end
end
