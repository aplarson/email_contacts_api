# == Schema Information
#
# Table name: contacts
#
#  id       :integer          not null, primary key
#  name     :string(255)      not null
#  email    :string(255)      not null
#  user_id  :integer          not null
#  favorite :boolean          default(FALSE)
#

class Contact < ActiveRecord::Base
  validates :name, :email, :user_id, presence: true
  validate :email_user_id_unique_combination, :on => :create 
  
  belongs_to(
    :owner,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
    )
  has_many(
    :contact_shares,
    dependent: :destroy,
    class_name: "ContactShare",
    foreign_key: :contact_id,
    primary_key: :id
    )
  has_many(
    :shared_users,
    :through => :contact_shares,
    :source => :user
  )  
  has_many(
  :comments, as: :commentable
  )
  
  has_many(
    :group_memberships,
    class_name: "ContactGroupMembership",
    foreign_key: :contact_id,
    primary_key: :id
    )
  has_many(
    :groups,
    through: :group_memberships,
    source: :group
    )
  def email_user_id_unique_combination
    if Contact.where('user_id = ? AND email = ?', self.user_id, self.email).exists?
      errors[:contact] << "must be unique"
    end
  end
end
