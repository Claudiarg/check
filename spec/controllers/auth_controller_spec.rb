require 'rails_helper'
require 'json'

RSpec.describe AuthController, type: :request do

  describe 'login' do
    let(:password) { FFaker::Internet.password }
    let(:user) { FactoryBot.create(:user, password: password) }

    it 'valid credentials' do
      post '/auth/login', params: { email: user.email, password: password }
      expect(response.status).to eq 200
      response_body = JSON.parse(response.body)
      user.reload
      expect(response_body['token']).to eq user.auth_token
      expect(response_body['user_id']).to eq user.id
    end

    it 'invalid credentials' do
      post '/auth/login', params: { email: user.email, password: FFaker::Internet.password }
      expect(response.status).to eq 401
    end
  end

  describe 'logout' do
    let(:password) { FFaker::Internet.password }
    let(:user) { FactoryBot.create(:user, password: password) }

    it 'delete session' do
      post '/auth/login', params: { email: user.email, password: password }
      token = JSON.parse(response.body)['token']

      delete '/auth/logout', params: {}, headers: {"Authorization" => token }
      expect(response.status).to eq 200
    end
  end
end
