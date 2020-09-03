class LikesController < ApplicationController
  def create
    item = Item.find_by(id: params[:item_id])
    binding.pry
    if item.likes.ids.include?(current_user.likes.ids)
      @like = nil
    else
      @like = current_user.likes.create(item_id: params[:item_id])
    end
    render json: {post: @like}
    # redirect_to :root_path
  end

  def destroy
    @like = Like.find_by(item_id: params[:item_id, user_id: current_user.id])
    @like.destroy
    @like = nil
    render json: {post: @like}
  end
end
