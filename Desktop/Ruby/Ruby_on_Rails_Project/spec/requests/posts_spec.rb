
require 'rails_helper'

RSpec.describe Post, type: :request do
  let(:file){Rack::Test::UploadedFile.new('/home/dinesh/Desktop/Ruby/1/public/5.jpg', 'image/jpg')}
  before do
    @user = FactoryBot.create :user
    @post = FactoryBot.create(:post, user_id: @user.id, image: file)
    @find_post = Post.find(@post.id)
  end

  describe 'without login' do
    describe 'GET/index' do
      before(:example) {get posts_path}
      it 'assings all posts to @posts' do
        expect(assigns(:posts)).to eq(Post.all)
      end

      it "renders 'index' template" do
        expect(response).to render_template('index')
      end

      it 'response is a success' do
        expect(response).to have_http_status(:ok)
      end
    end
  
    describe 'GET/show' do
      it 'should assign comments in @comments' do
        @comments = @find_post.comments
        get post_path(@find_post)
        expect(assigns(:comments)).to eq(@comments)
      end
  
      it 'renders a successful response' do
        get post_path(@post)
        expect(response).to be_successful
      end
    end
  end

  describe 'with login' do
    let(:login) {post new_user_session_path, params: {
      user: {
        email: @user.email,
        password: @user.password
      }
    }}

    before(:example){login}

    let(:valid_attributes) {
      {
      title: 'Title',
      description: 'Some content',
      image: file,
      user_id: @user.id
      }
    }
  
    let(:invalid_attributes) {
      {
        title: 'Title',
        description: 'Some content',
        user_id: @user.id
        }
    }
    describe 'GET/new' do
      it 'render a successful response' do
        get new_post_path
        expect(response).to be_successful
      end
    end
  
    describe 'GET/edit' do
      it 'render a successful response' do
        get edit_post_path(@post)
        expect(response).to be_successful
      end
    end

    describe 'POST/create' do
      context "with valid parameters" do
        it "creates a new Post" do
          expect {
            post posts_path, params: { post: valid_attributes }
          }.to change(Post, :count).by(1)
        end
  
        it "redirects to the created post" do
          post posts_path, params: { post: valid_attributes }
          expect(response).to redirect_to(post_path(Post.last))
        end
      end
  
      context "with invalid parameters" do
        it "does not create a new Post" do
          expect {
            post posts_path, params: { post: invalid_attributes }
          }.to change(Post, :count).by(0)
        end
  
        it "renders a successful response" do
          post posts_path, params: { post: invalid_attributes }
          get new_post_path
          expect(response).to render_template(:new)
          expect(response.body).to include "Something wents wrong, must fill all the fields"
        end
      end
    end

    describe "PATCH /update" do
      context "with valid parameters" do
        let(:new_attributes) {
          {
            title: 'Title-Edited',
            description: 'Some content',
            image: file,
            user_id: @user.id
            }
        }
  
        it "updates the requested post" do
          patch post_path(@post), params: { post: new_attributes }
          @post.reload
          expect(@post.title).to eq('Title-Edited')
        end
  
        it "redirects to the post" do
          patch post_path(@post), params: { post: new_attributes }
          @post.reload
          expect(response).to redirect_to(post_path(@post))
        end
      end
  
      context "with invalid parameters" do
        it "renders a successful response" do
          patch post_path(@post), params: { post: invalid_attributes }
          get edit_post_path(@post)
          expect(response).to be_successful
        end
      end
    end

    describe "DELETE/destroy" do
      it "destroys the requested post" do
        expect {
          delete post_path(@post)
        }.to change(Post, :count).by(-1)
      end
  
      it "redirects to the posts page" do
        delete post_path(@post)
        expect(response).to redirect_to(root_path)
      end
    end

    describe 'GET/ mypost' do
      it 'should assigns posts into @posts' do
        get mypost_path(:posts)
        expect(assigns(:posts)).to eq(Post.all)
      end
    end
  end
end
