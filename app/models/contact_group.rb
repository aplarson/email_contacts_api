# == Schema Information
#
# Table name: contact_groups
#
#  id       :integer          not null, primary key
#  name     :string(255)      not null
#  owner_id :integer          not null
#

class ContactGroup < ActiveRecord::Base
  validates :name, :owner_id, presence: true
  belongs_to(
    :owner,
    class_name: "User",
    foreign_key: :owner_id,
    primary_key: :id
    )
    
  has_many(
    :memberships,
    class_name: "ContactGroupMembership",
    foreign_key: :group_id,
    primary_key: :id
    )
  has_many(
    :contacts,
    through: :memberships,
    source: :contact
    )
end
