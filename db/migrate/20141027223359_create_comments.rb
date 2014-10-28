class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :commentable_id, :null => false
      t.string :commentable_type, :null => false
      t.integer :commenter_id, :null => false  
      t.text :body, :null => false
    end
    add_index :comments, :commenter_id
    add_index :comments, [:commentable_id, :commentable_type]
  end
end
