class CommentsController < ApplicationController
  before_action :set_product

  def index
    @comment = Comment.new
    @comments = @product.comments.includes(:user)
    respond_to do |format|
      format.html
      format.json {@new_comments = Comment.where('id > ?', params[:id])}
    end
  end

  def create
    @comment = @product.comments.new(comment_params)
    if @comment.save
      respond_to do |format|
        format.html{redirect_to product_path(@product), notice: 'コメントしました'}
        format.json
      end

    else
      @comments = @product.comments.includes(:user)
      flash.now[:alert] = 'コメントを入力してください。'
      render :index
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id)
  end

  def set_product
    @product = Product.find(params[:product_id])
  end

end
