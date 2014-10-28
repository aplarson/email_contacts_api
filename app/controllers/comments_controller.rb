class CommentsController < ApplicationController
  def index
    if params[:contact_id]
      render(
        json: Comment.where("commentable_id = ? AND commentable_type = ?", 
                            params[:contact_id], 
                            "Contact")
      )
    elsif params[:user_id]
      render(
        json: Comment.where("commentable_id = ? AND commentable_type = ?", 
                            params[:user_id], 
                            "User")
      )
    end
  end
  
  def create
    comment = Comment.new(comment_params)
    
    if comment.save
      render json: comment
    else
      render(
        json: comment.errors.full_messages, status: :unprocessable_entity
        )
    end
  end 
  
  def destroy
    comment = Comment.find(params[:id])
    
    comment.delete
    render json: comment
  end
  
  def show
    render json: Comment.find(params[:id])
  end
 
  
  def update
    comment = Comment.find(params[:id])
    
    if comment.update(comment_params)
      render json: comment
    else
      render json: comment.errors.full_messages, status: :unprocessable_entity
    end
  end
  
  private
  def comment_params
    params.require(:comment).permit(:commentable_id, :commentable_type, :commenter_id, :body)
  end
end