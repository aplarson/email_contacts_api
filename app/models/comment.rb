# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  commentable_id   :integer          not null
#  commentable_type :string(255)      not null
#  commenter_id     :integer          not null
#  body             :text             not null
#

class Comment < ActiveRecord::Base
  validates :commentable_id, :commentable_type, :commenter_id, :body, :presence => true
  validate :valid_commentable_type
  
  COMMENTABLE_TYPES = ["User", "Contact", "ContactShare"]
  
  belongs_to(
  :commentable, polymorphic: true
  )
  
  belongs_to(
  :user,
  :class_name => "User",
  :foreign_key => :commenter_id,
  :primary_key => :id
  )
  
  private
  
  def valid_commentable_type
    unless COMMENTABLE_TYPES.include?(self.commentable_type)
      errors[:commentable_type] << "must be 'User', 'Contact', or 'ContactShare'"
    end
  end
  
end
