require 'rails_helper'

RSpec.describe Post, type: :model do
  before(:all){
    @user = FactoryBot.create :user
    @post1 = FactoryBot.create(:post, user_id: @user.id)
  }
  describe 'validating post' do
    it 'should be able to create new post with valid inputs' do
      expect(@post1).to be_valid
    end
  
    it "is not valid without a title" do
      @post1.title = nil
      expect(@post1).to_not be_valid
    end
    
    it "is not valid without a description" do
      @post1.description = nil
      expect(@post1).to_not be_valid
    end
  
    it "is not valid without a image" do
      @post1.image = nil
      expect(@post1).to_not be_valid
    end
  
    it "is not valid without a user_id" do
      @post1.user_id = nil
      expect(@post1).to_not be_valid
    end
  end

  describe 'should navigate to prev and next' do
    it 'prev button should navigate to previous post' do
      new_post = FactoryBot.create(:post, user_id: @user.id)
      expect(Post.where(["id < ?", new_post.id]).last).to eq(@post1)
    end

    it 'next button should navigate to next post' do
      new_post = FactoryBot.create(:post, user_id: @user.id)
      expect(Post.where(["id > ?", @post1.id]).first).to eq(new_post)
    end
  end
end
