class CreateJira < ActiveRecord::Migration
  def change
    create_table :jiras do |t|
      t.string :site_url
      t.string :consumer_key
      t.text :private_key
      t.string :oauth_verifier
      t.belongs_to :user

      t.timestamps
    end
  end
end
