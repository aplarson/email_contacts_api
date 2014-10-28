# == Schema Information
#
# Table name: users
#
#  id       :integer          not null, primary key
#  username :string(255)
#

class User < ActiveRecord::Base
  validates :username, presence: true, uniqueness: true
  
  has_many(
    :contacts,
    dependent: :destroy,
    class_name: "Contact",
    foreign_key: :user_id,
    primary_key: :id
  )
    
  has_many(
    :contact_shares,
    dependent: :destroy,
    class_name: "ContactShare",
    foreign_key: :user_id,
    primary_key: :id
  )    
    
  has_many(
    :shared_contacts,
    :through => :contact_shares,
    :source => :contact
  )
  
  has_many(
  :comments, as: :commentable
  )
  
  has_many(
  :authored_comments,
  :class_name => "Comment",
  :foreign_key => :commenter_id,
  :primary_key => :id
  )
  
  has_many(
    :contact_groups,
    class_name: "ContactGroup",
    foreign_key: :owner_id,
    primary_key: :id
    )
  
end
