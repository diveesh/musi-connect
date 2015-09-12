class AddColumnsUser < ActiveRecord::Migration
  def change
    add_column :users, :instrument_info, :string
    add_column :users, :genre_info, :string
    add_column :users, :activity_info, :string
    add_column :users, :interest_info, :string
  end
end
