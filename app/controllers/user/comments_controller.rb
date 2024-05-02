class User::CommentsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :respond_bad_request

  def index
    author = User.find_by!(username: params.require(:username))
    comments = Comment.where(author: author)
                      .limit(pagination_params[:limit])
                      .offset(pagination_params[:offset])
    render json: comments
  end

  private

  def respond_bad_request
    render json: { message: 'There is no comment' }, status: :bad_request
  end

  def pagination_params
    params.permit(
      :offset,
      :limit
    ).with_defaults(
      offset: 0,
      limit: 50,
    )
  end
end
