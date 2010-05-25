class CreateTodos < ActiveRecord::Migration
  def self.up
    create_table :todos do |t|
      t.text :subject
      t.belongs_to :list
      t.timestamps
    end
  end

  def self.down
    drop_table :todos
  end
end
