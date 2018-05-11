require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  fixtures :posts, :users, :ips

  describe 'POST #create' do
    let(:valid_user) { users(:valid) }
    let(:valid_ip) { ips(:valid) }
    let(:new_user_params) { { login: 'new_login', ip: Faker::Internet.ip_v4_address } }

    context 'with valid params' do
      let(:valid_post) { posts(:valid_first) }
      let(:existing_user_params) { { login: valid_user.login, ip: valid_ip.ip } }
      let(:new_post_params) { { title: valid_post.title, body: valid_post.body } }

      context 'creates new post with new user and new ip' do
        subject { lambda { post :create, params: { post: new_post_params, user: new_user_params } } }
        
        it { should change(User, :count).by 1 }
        it { should change(Ip, :count).by 1 }
        it { should change(Post, :count).by 1 }
      end

      context 'creates new post with existing user and existing ip' do
        subject { lambda { post :create, params: { post: new_post_params, user: existing_user_params } } }

        it { should_not change(User, :count) }
        it { should_not change(Ip, :count) }
        it { should change(Post, :count).by 1 }
      end

      context 'valid return' do
        before(:each) { post :create, params: { post: new_post_params, user: new_user_params } }

        it 'should return valid post' do
          json_response = JSON.parse(response.body)
          expect(json_response['id']).to be
          expect(json_response['title']).to eq valid_post.title
          expect(json_response['body']).to eq valid_post.body
        end

        it 'should return valid status' do
          expect(response.status).to eq 200
        end
      end
    end

    context 'with invalid params' do
      let(:invalid_post) { posts(:invalid) }
      let(:new_invalid_post_params) { { title: invalid_post.title, body: invalid_post.body } }
      context 'invalid post params' do
        subject { lambda { post :create, params: { post: new_invalid_post_params , user: new_user_params } } }

        it { should_not change(User, :count) }
        it { should_not change(Ip, :count) }
        it { should_not change(Post, :count) }
      end

      context 'invalid return' do
        before(:each) { post :create, params: { post: new_invalid_post_params , user: new_user_params } }

        it 'should return error post title' do
          json_response = JSON.parse(response.body)
          expect(json_response['errors']['title']).to be
        end

        it 'should return invalid status' do
          expect(response.status).to eq 422
        end
      end
    end
  end

  describe 'POST #vote' do
    let(:valid_post) { posts(:valid_first) }
    context 'with valid params' do
      let(:valid_post_rating_params) { { rating: '5' } }
      subject { lambda { post :vote, params: { post: valid_post_rating_params, id: valid_post.id } } }

      it { should change(PostRating, :count).by 1 }

      context 'valid return post rating' do
        before(:each) { post :vote, params: { post: valid_post_rating_params, id: valid_post.id } }

        it 'should return valid post average rating' do
          json_response = JSON.parse(response.body)
          expect(json_response['id']).to be
          expect(json_response['avg_rating']).to eq '5.0'
        end

        it 'should return valid status' do
          expect(response.status).to eq 200
        end
      end
    end

    context 'with invalid params' do
      let(:invalid_post_rating_params) { { rating: '6' } }
      subject { lambda { post :vote, params: { post: invalid_post_rating_params, id: valid_post.id } } }
      it { should_not change(PostRating, :count) }

      context 'invalid return post rating' do
        before(:each) { post :vote, params: { post: invalid_post_rating_params, id: valid_post.id } }

        it 'should return error post rating' do
          json_response = JSON.parse(response.body)
          expect(json_response['errors']['rating']).to be
        end

        it 'should return invalid status' do
          expect(response.status).to eq 422
        end
      end

      context 'post not found' do
        before(:each) { post :vote, params: { post: invalid_post_rating_params, id: -1 } }
        it 'should return error post not found' do
          json_response = JSON.parse(response.body)
          expect(json_response['errors']['post_id']).to be
        end
      end
    end
  end

  describe 'GET #top' do
    let(:valid_post) { posts(:valid_first) }

    context 'with valid params' do
      before(:each) { get :top, params: { count: 10 } }

      it 'should return valid status' do
        expect(response.status).to eq 200
      end

      it 'should return valid posts array' do
        json_response = JSON.parse(response.body)
        expect(json_response['posts'][0]['avg_rating']).to be > json_response['posts'][1]['avg_rating']
      end
    end
  end

  describe 'GET #ip_list' do
    context 'with valid params' do
      let(:valid_ip) { ips(:valid) }
      let(:valid_user) { users(:valid) }
      before(:each) { get :ip_list }

      it 'should return valid status' do
        expect(response.status).to eq 200
      end

      it 'should return valid ip list array' do
        json_response = JSON.parse(response.body)
        expect(json_response[0]['ip']).to eq valid_ip.ip.to_s
        expect(json_response[0]['logins'][0]).to eq valid_user.login
      end
    end
  end
end