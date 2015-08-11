class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
        t.column :first_name, :string
        t.column :last_name, :string
        t.column :login_name, :string
        t.column :level_anchor, :string
        t.column :email_address, :string
        t.column :affiliation, :string
        t.column :photo_file_name, :string
        t.column :password_digest, :string
        t.column :salt, :string
        t.column :description, :string
      t.timestamps
    end
  end
end
