class ContactGroupsController < ApplicationController
  
  def index
    render json: ContactGroup.where('owner_id = ?', params[:user_id])
  end
  
  def create
    contact_group = ContactGroup.new(param_helper)
    if contact_group.save
      render json: contact_group
    else
      render(
      json: contact_group.errors.full_messages, status: :unprocessable_entity
      )
    end
  end
  
  def update
    contact_group = ContactGroup.find(params[:id])
    if contact_group.update(param_helper)
      render json: contact_group
    else
      render(
      json: contact_group.errors.full_messages, status: :unprocessable_entity
      )
    end
  end
  
  def destroy
    contact_group = ContactGroup.find(params[:id])
    contact_group.delete
    render json: contact_group
  end
  
  def show
    group = ContactGroup.find(params[:id])
    render json: { group.name => group.contacts }
  end
  
  private
  def param_helper
    params.require(:contact_group).permit(:owner_id, :name)
  end
end