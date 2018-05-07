require 'rails_helper'

RSpec.describe PostCreator do
  fixtures :posts, :users, :ips

  describe '#save' do
    let(:valid_user) { users(:valid) }
    let(:valid_ip) { ips(:valid) }
    let(:new_user_params) { { login: 'new_login', ip: Faker::Internet.ip_v4_address } }
    let(:new_post_params) { { title: valid_post.title, body: valid_post.body } }
    context 'with valid params' do
      let(:valid_post) { posts(:valid) }
      let(:existing_user_params) { { login: valid_user.login, ip: valid_ip.ip } }

      context 'should save post with save new user and save new ip' do
        subject { lambda { PostCreator.new(new_post_params, new_user_params).save } }

        it { should change(User, :count).by 1 }
        it { should change(Ip, :count).by 1 }
        it { should change(Post, :count).by 1 }
      end

      context 'should save post with existing user and existing ip' do
        subject { lambda { PostCreator.new(new_post_params, existing_user_params).save } }

        it { should_not change(User, :count) }
        it { should_not change(Ip, :count) }
        it { should change(Post, :count).by 1 }
      end
    end

    context 'with invalid params' do
      let(:invalid_post) { posts(:invalid) }
      let(:new_invalid_post_params) { { title: invalid_post.title, body: invalid_post.body } }

      context 'should not save post with not save new user and not save new ip' do
        subject { lambda { PostCreator.new(new_invalid_post_params, new_user_params).save } }

        it { should_not change(User, :count) }
        it { should_not change(Ip, :count) }
        it { should_not change(Post, :count) }
      end
    end
  end
end