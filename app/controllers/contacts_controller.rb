class ContactsController < ApplicationController
  def index
    user = User.find(params[:user_id])
    render json: {contacts: user.contacts, shared_contacts: user.shared_contacts}
    # render json: Contact.where('user_id = ?', params[:user_id])
  end
  
  def create
    contact = Contact.new(contact_params)
    
    if contact.save
      render json: contact
    else
      render(
        json: contact.errors.full_messages, status: :unprocessable_entity
        )
    end
  end 
  
  def destroy
    contact = Contact.find(params[:id])
    
    contact.delete
    render json: contact
  end
  
  def show
    render json: Contact.find(params[:id])
  end
 
  
  def update
    contact = Contact.find(params[:id])
    
    if contact.update(contact_params)
      render json: contact
    else
      render json: contact.errors.full_messages, status: :unprocessable_entity
    end
  end
  
  def favorite
    contact = Contact.find(params[:id])
    if contact.update("favorite" => !contact.favorite)
      render json: contact
    else
      render json: contact.errors.full_messages
    end
  end
  
  private
  def contact_params
    params.require(:contact).permit(:name, :email, :user_id)
  end
end