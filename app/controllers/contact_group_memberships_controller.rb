class ContactGroupMembershipsController < ApplicationController
  
  def create
    member = ContactGroupMembership.new(params_helper)
    if member.save
      render json: member
    else
      render(
      json: member.errors.full_messages, status: :unprocessable_entity
      )
    end
  end
  
  def destroy
    membership = ContactGroupMembership.find(params[:id])
    membership.delete
    render json: membership
  end
  
  private
  def params_helper
    params.permit(:group_id, :contact_id)
  end
  
end