class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
        t.column :name, :string
      t.timestamps
    end
  end
end
