namespace :admin do
  desc "create subscription plans"
  task :create_plans => :environment do
    names = ['silver', 'gold', 'platinum']
    prices = [24.00, 49.00, 99.00]
    max_projects = [3, 10, 0]
    (0...names.length).each do |i|
      SubscriptionPlan.create(name: names[i], price: prices[i], number_of_projects: max_projects[i])
    end
    print "Plans created.\n"
  end
end
