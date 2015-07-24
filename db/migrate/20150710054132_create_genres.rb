class CreateGenres < ActiveRecord::Migration
  def change
    create_table :genres do |t|
        t.column :name, :string
      t.timestamps
    end
  end
end
