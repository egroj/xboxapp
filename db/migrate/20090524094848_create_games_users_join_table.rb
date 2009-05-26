class CreateGamesUsersJoinTable < ActiveRecord::Migration
  def self.up
	create_table :games_users, :id => false do |t|
      t.column :game_id,	:integer
      t.column :user_id,	:integer
    end
  end

  def self.down
	drop_table :games_users
  end
end
