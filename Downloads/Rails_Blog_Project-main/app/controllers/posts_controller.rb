class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  def index
    @posts = Post.all
  end

  def new
    # @post = Post.new
    @post = current_user.posts.build
  end

  def create
    # @post = Post.new(post_params)
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

  def show
    if params[:id] == 'my_post'
      @post_count = 0
      @posts = Post.all
      render 'posts/my_post'
    else
      @post = Post.find(params[:id])
      @comments = Post.find(params[:id]).comments
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to @post, :notice => "Post Updated Successfully!"
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to root_path, :notice => "Post has been deleted"
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :user_id, :image)
  end

end