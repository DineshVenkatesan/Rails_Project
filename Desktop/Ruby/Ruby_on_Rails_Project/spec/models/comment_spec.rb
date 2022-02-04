require 'rails_helper'
RSpec.describe Comment, type: :model do
  before(:all) {
    @user = FactoryBot.create :user
    @post = FactoryBot.create(:post, user_id: @user.id)
    @comment = Comment.create(
      body: 'dummy',
      post_id: @post.id,
      user_id: @post.user_id
    )
  }

  describe 'validation' do
    context 'with valid attributes' do
      it 'shoult able to comment' do
        expect(@comment).to be_valid
      end
    end

    context 'with invalid attributes' do
      it 'without post_id should not create comment' do
        @comment.post_id = nil
        expect(@comment).not_to be_valid
      end

      it 'without user_id should not create comment' do
        @comment.user_id = nil
        expect(@comment).not_to be_valid
      end

      it 'with empty content should not create comment' do
        @comment.body = ''
        expect(@comment).not_to be_valid
      end
    end
  end
end