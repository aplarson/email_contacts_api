class ContactSharesController < ApplicationController

  
  def create
    contact_share = ContactShare.new(contact_share_params)
    if contact_share.save
      render json: contact_share
    else
      render(
        json: contact_share.errors.full_messages, status: :unprocessable_entity
        )
    end
  end
    
  def destroy
    contact_share = ContactShare.find(params[:id])
    contact_share.delete
    render json: contact_share
  end
  
  def favorite
    contact = Contact.find(params[:contact_id])
    if contact.update("favorite" => !contact.favorite)
      render json: contact
    else
      render json: contact.errors.full_messages
    end
  end
  
  private
  def contact_share_params
    params.permit(:user_id, :contact_id)
  end
end