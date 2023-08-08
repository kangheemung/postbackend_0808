
class PostsController < ApplicationController
  def index
    @posts =Post.all
    render json: {messege: "successfully get posts",posts: @posts}
  end
  def create
    post = Post.new(post_params)
    if post.save
      render json: post
    else
      render json: post.erros, status: 422
    end
  end

  def new
  end

  def show
    render json: Post.find(params[:id])

  end
  def update
    post = Post.find(params[:id])
    if post.update(post_params)
      render json: post
    else
      render json: post.errors, status: 422
    end
  end

  def edit
  end
  def post_params
    params.require(:post).permit(:title, :content,:user_id)
  end
end