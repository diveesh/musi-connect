class CreateGenresUsersJoinTable < ActiveRecord::Migration
  def change
    create_table :genres_users, id: false do |t|
        t.belongs_to :genre, index: true
        t.belongs_to :user, index: true
    end
  end
end
