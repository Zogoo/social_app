require 'rails_helper'

RSpec.describe User::CommentsController, type: :request do
  describe 'GET #index' do
    let(:user) { create(:user) }
    let(:post) { create(:post, user: user) }
    let!(:comment1) { create(:comment, post: post, author: user) }
    let!(:comment2) { create(:comment, post: post, author: create(:user)) }

    it 'returns a list of comments authored by the specified user' do
      get "/user/comments", params: { username: user.username }
      expect(response).to have_http_status(:success)
      
      user_comments = JSON.parse(response.body)
      expect(user_comments.count).to eq(1)
      expect(user_comments.first['user_id']).to eq(user.id)
    end

    it 'returns an empty list if user has no comments' do
      get "/user/comments", params: { username: 'nonexistent_user' }
      expect(response).to have_http_status(:success)
      
      user_comments = JSON.parse(response.body)
      expect(user_comments).to be_empty
    end
  end
end
