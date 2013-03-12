require './lib/list'
require './lib/task'

class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.column :name, :string
      t.timestamps
    end
    default_list = List.create(:name => 'default list')

    add_column :tasks, :list_id, :integer
    Task.all.each {|task| task.update_attributes(:list_id => default_list.id)}
  end
end
