class Users < ActiveRecord::Migration
  def self.up
    add_column :users, :online, :boolean, :default => false
  end

  def self.down
  end
end
