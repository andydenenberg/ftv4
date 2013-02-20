class AddPinIndex < ActiveRecord::Migration
  def self.up
    add_index :properties, :pin
    add_index :details, :pin
    add_index :owners, :pin
  end
  def down
    remove_index :properties, :pin
    remove_index :details, :pin
    remove_index :owners, :pin
  end
end
