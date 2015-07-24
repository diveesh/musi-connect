class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
        t.column :first_name, :string
        t.column :last_name, :string
        t.column :login_name, :string
        t.column :level_anchor, :string
        t.column :email_address, :string
        t.column :affiliation, :string
        t.column :statement, :string
        t.column :password_digest, :string
        t.column :salt, :string
        t.column :profile_set, :boolean
      t.timestamps
    end
  end
end
