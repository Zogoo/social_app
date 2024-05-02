class User::CommentsController < ApplicationController
  def index
    posts = Post.all
    comments = posts.map(&:comments).flatten
    @user_comments = comments.select do |comment|
      comment.author.username == params[:username]
    end

    render json: @user_comments
  end
end
