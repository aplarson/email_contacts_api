# == Schema Information
#
# Table name: contact_group_memberships
#
#  id         :integer          not null, primary key
#  group_id   :integer          not null
#  contact_id :integer          not null
#

class ContactGroupMembership < ActiveRecord::Base
  validates :group_id, :contact_id, presence: true
  
  belongs_to(
    :contact,
    class_name: "Contact",
    foreign_key: :contact_id,
    primary_key: :id
    )
  
  belongs_to(
    :group,
    class_name: "ContactGroup",
    foreign_key: :group_id,
    primary_key: :id
    )
end
