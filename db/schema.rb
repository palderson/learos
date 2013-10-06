# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130811112529) do

  create_table "billings", :force => true do |t|
    t.text     "payment_processing_method"
    t.text     "billing_process_steps"
    t.text     "billing_update_requirements"
    t.text     "contract_requirements"
    t.integer  "project_id"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.hstore   "data"
  end

  add_index "billings", ["data"], :name => "index_billings_on_data"
  add_index "billings", ["project_id"], :name => "index_billings_on_project_id"

  create_table "client_trainings", :force => true do |t|
    t.string   "company_training_materials"
    t.string   "user_training_materials"
    t.integer  "project_id"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.string   "file_url"
    t.hstore   "data"
  end

  add_index "client_trainings", ["data"], :name => "index_client_trainings_on_data"
  add_index "client_trainings", ["project_id"], :name => "index_client_trainings_on_project_id"

  create_table "collaborations", :force => true do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "collaborations", ["project_id"], :name => "index_collaborations_on_project_id"
  add_index "collaborations", ["user_id"], :name => "index_collaborations_on_user_id"

  create_table "comments", :force => true do |t|
    t.integer  "commentable_id",   :default => 0
    t.string   "commentable_type", :default => ""
    t.string   "title",            :default => ""
    t.text     "body",             :default => ""
    t.string   "subject",          :default => ""
    t.integer  "user_id",          :default => 0,  :null => false
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  add_index "comments", ["commentable_id", "commentable_type"], :name => "index_comments_on_commentable_id_and_commentable_type"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "goals", :force => true do |t|
    t.text     "six_week_goals"
    t.text     "three_month_goals"
    t.text     "six_month_goals"
    t.integer  "project_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.hstore   "data"
  end

  add_index "goals", ["data"], :name => "index_goals_on_data"
  add_index "goals", ["project_id"], :name => "index_goals_on_project_id"

  create_table "internal_trainings", :force => true do |t|
    t.string   "individual_training_materials"
    t.string   "group_training_materials"
    t.integer  "project_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.string   "file_url"
    t.hstore   "data"
  end

  add_index "internal_trainings", ["data"], :name => "index_internal_trainings_on_data"
  add_index "internal_trainings", ["project_id"], :name => "index_internal_trainings_on_project_id"

  create_table "marketings", :force => true do |t|
    t.text     "overview"
    t.text     "external_messaging"
    t.text     "internal_messaging"
    t.string   "marketing_budget"
    t.text     "alpha_invite_email"
    t.text     "beta_invite_email"
    t.integer  "project_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "file_url"
    t.hstore   "data"
  end

  add_index "marketings", ["data"], :name => "index_marketings_on_data"
  add_index "marketings", ["project_id"], :name => "index_marketings_on_project_id"

  create_table "onboardings", :force => true do |t|
    t.text     "step_one"
    t.text     "step_two"
    t.text     "step_three"
    t.text     "step_four"
    t.text     "step_five"
    t.integer  "project_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.hstore   "data"
  end

  add_index "onboardings", ["data"], :name => "index_onboardings_on_data"
  add_index "onboardings", ["project_id"], :name => "index_onboardings_on_project_id"

  create_table "overviews", :force => true do |t|
    t.text     "elevator_pitch"
    t.text     "value_proposition"
    t.text     "internal_motivations"
    t.integer  "project_id"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.string   "file_url"
    t.hstore   "data"
  end

  add_index "overviews", ["data"], :name => "index_overviews_on_data"
  add_index "overviews", ["project_id"], :name => "index_overviews_on_project_id"

  create_table "plans", :force => true do |t|
    t.text     "attention"
    t.text     "interest"
    t.text     "desire"
    t.text     "action"
    t.integer  "project_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.hstore   "data"
  end

  add_index "plans", ["data"], :name => "index_plans_on_data"
  add_index "plans", ["project_id"], :name => "index_plans_on_project_id"

  create_table "products", :force => true do |t|
    t.text     "description"
    t.integer  "project_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.hstore   "data"
  end

  add_index "products", ["data"], :name => "index_products_on_data"
  add_index "products", ["project_id"], :name => "index_products_on_project_id"

  create_table "profiles", :force => true do |t|
    t.text     "ideal_client"
    t.string   "applicable_client_percentage"
    t.text     "client_motivations"
    t.string   "target_budget"
    t.string   "purchase_decision_maker"
    t.string   "product_user"
    t.integer  "project_id"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.hstore   "data"
  end

  add_index "profiles", ["data"], :name => "index_profiles_on_data"
  add_index "profiles", ["project_id"], :name => "index_profiles_on_project_id"

  create_table "projects", :force => true do |t|
    t.string   "title"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "user_id"
    t.boolean  "archived",   :default => false
  end

  add_index "projects", ["user_id"], :name => "index_projects_on_user_id"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "rollouts", :force => true do |t|
    t.text     "what_went_well"
    t.text     "what_could_have_gone_better"
    t.text     "what_surprised_you"
    t.text     "lesson_learned"
    t.integer  "project_id"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.hstore   "data"
  end

  add_index "rollouts", ["data"], :name => "index_rollouts_on_data"
  add_index "rollouts", ["project_id"], :name => "index_rollouts_on_project_id"

  create_table "servicings", :force => true do |t|
    t.text     "description"
    t.integer  "project_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.hstore   "data"
  end

  add_index "servicings", ["data"], :name => "index_servicings_on_data"
  add_index "servicings", ["project_id"], :name => "index_servicings_on_project_id"

  create_table "subscription_plans", :force => true do |t|
    t.string   "name"
    t.decimal  "price"
    t.integer  "number_of_projects"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "subscriptions", :force => true do |t|
    t.string   "stripe_customer_token"
    t.string   "status"
    t.datetime "expire_date"
    t.integer  "last_4_digits"
    t.integer  "user_id"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.integer  "subscription_plan_id"
  end

  add_index "subscriptions", ["subscription_plan_id"], :name => "index_subscriptions_on_subscription_plan_id"
  add_index "subscriptions", ["user_id"], :name => "index_subscriptions_on_user_id"

  create_table "test_clients", :force => true do |t|
    t.string   "description"
    t.integer  "project_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.hstore   "data"
  end

  add_index "test_clients", ["data"], :name => "index_test_clients_on_data"
  add_index "test_clients", ["project_id"], :name => "index_test_clients_on_project_id"

  create_table "users", :force => true do |t|
    t.string   "email",                                :default => "", :null => false
    t.string   "encrypted_password",                   :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                        :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at",                                           :null => false
    t.string   "name"
    t.string   "filepicker_url"
    t.string   "invitation_token",       :limit => 60
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

end
