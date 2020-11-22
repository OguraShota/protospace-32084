class CommentsController < ApplicationController

  def index
    @comment = Comment.new
    @prototype = Prototype.find(params[:prototype_id])
  end

  def create
    @comment = Comment.new(comments_params)
    if @comment.save
     redirect_to "/prototypes/#{@comment.prototype.id}"
    else
      @prototype = @comment.prototype
      @comments = @prototype.comments
      render "prototypes/show"
    end
  end

  private
  def comments_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end

end
