require 'rails_helper'

RSpec.describe User::CommentsController, type: :request do
  describe 'GET #index' do
    let(:user) { create(:user) }
    let(:post) { create(:post, user: user) }
    
    context 'when existing user name is provided' do
      let!(:comment) { create(:comment, post: post, author: user) }

      it 'returns a list of comments authored by the specified user' do
        get "/user/comments", params: { username: user.username }
        expect(response).to have_http_status(:success)
        
        user_comments = response.parsed_body
        expect(user_comments.count).to eq(1)
        expect(user_comments.first['user_id']).to eq(user.id)
      end
    end

    context 'when user does not exist' do
      it 'return bad request' do
        get "/user/comments", params: { username: 'nonexistent_user' }
        expect(response).to have_http_status(:bad_request)
        expect(response.parsed_body['message']).to eq('There is no comment')
      end
    end

    context 'when pagination params specified' do
      let!(:comments) { create_list(:comment, 100, post: post, author: user) }

      it 'will return comments only on the specified page' do
        get "/user/comments", params: { username: user.username, offset: 20, limit: 20 }
        expect(response).to have_http_status(:success)
        user_comments = response.parsed_body
        expect(user_comments.count).to eq(20)
        expect(user_comments.first['id']).to eq(comments[20].id)
      end
    end
  end
end
