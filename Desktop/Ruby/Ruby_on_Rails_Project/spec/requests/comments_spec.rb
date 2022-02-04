require 'rails_helper'

RSpec.describe Comment, type: :request do
describe 'Comments' do
    before(:all) do
        @user = FactoryBot.create :user
        @post = FactoryBot.create :post, user_id: @user.id
        @comment = Comment.create(
            body: 'some content',
            post_id: @post.id,
            user_id: @user.id
        )
    end
        context 'Create' do
            it 'finding the post' do
                expect(@post).to eq(Post.find(@post.id))
            end
    
            it 'creating comment' do
                expect(@comment.save).to be(true)
            end

            it 'after creating comment should redirect to the post' do
                get post_path(@post)
                expect(response).to be_successful
            end
        end

        context 'destroy' do
            it 'should find the comment' do
                expect(@comment).to eq(Comment.find(@comment.id))
            end

            it 'should valid the destroy' do
                expect(@comment.destroy).to be_valid
            end

            it 'after destroy should redirect to the post' do
                get post_path(@post)
                expect(response).to be_successful
            end
        end
    end
end