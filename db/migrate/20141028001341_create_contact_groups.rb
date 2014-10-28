class CreateContactGroups < ActiveRecord::Migration
  def change
    create_table :contact_groups do |t|
      t.string :name, null: false
      t.integer :owner_id, null: false
    end
    
    add_index :contact_groups, :owner_id
    
    create_table :contact_group_memberships do |t|
      t.integer :group_id, null: false
      t.integer :contact_id, null: false
    end
    
    add_index :contact_group_memberships, :group_id
    add_index :contact_group_memberships, :contact_id
    add_index :contact_group_memberships, [:group_id, :contact_id], unique: true
  end
end
