class CreateInstrumentSkills < ActiveRecord::Migration
  def change
    create_table :instrument_skills do |t|
      t.integer :instrument_id
      t.integer :user_id
      t.string :level

      t.timestamps
    end
  end
end
