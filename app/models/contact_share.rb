# == Schema Information
#
# Table name: contact_shares
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  contact_id :integer          not null
#  favorite   :boolean          default(FALSE)
#

class ContactShare < ActiveRecord::Base
  validates :contact_id, :user_id, presence: true
  validate :unique_contact_share
  
  belongs_to(
    :user, 
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
    )
    
  belongs_to(
    :contact,
    class_name: "Contact",
    foreign_key: :contact_id,
    primary_key: :id
    )
  has_many(
    :comments, as: :commentable
    )
  
  def unique_contact_share
    !(Contact.where('user_id = ? AND contact_id = ?', 
                     self.user_id, self.contact_id))
  end
end
