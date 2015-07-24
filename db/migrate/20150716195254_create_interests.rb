class CreateInterests < ActiveRecord::Migration
  def change
    create_table :interests do |t|
        t.column :name, :string
      t.timestamps
    end
  end
end
