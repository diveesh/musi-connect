class CreateInstrumentsUsersJoinTable < ActiveRecord::Migration
  def change
    create_table :instruments_users, id: false do |t|
        t.belongs_to :instrument, index: true
        t.belongs_to :user, index: true
    end
  end
end
