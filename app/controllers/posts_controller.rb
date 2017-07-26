class PostsController < ApplicationController

 	def index
    @posts = Post.all
    @sierras = User.find_by_username('sierramclawhorn').posts
    @kianas = User.find_by_username('kianaseymour').posts
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @user = current_user
    @post = @user.posts.create(post_params)
    if @post.save 
      redirect_to posts_path
    else
      render 'new'
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post.id)
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id]).destroy
    redirect_to posts_path
  end

  private

    def post_params
      params.require(:post).permit(:date, 
                                   :title, 
                                   :body,
                                   :user)
    end


end
