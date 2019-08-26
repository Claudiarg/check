require 'rails_helper'

RSpec.describe CheckerController, type: :request do

  before :each do
    @user = FactoryBot.create(:user)
    post '/auth/login', params: { email: @user.email, password: @user.password }
    @authorization = @user.reload.auth_token
  end

  describe 'check' do
    it 'new check' do
      put '/check', params: {}, headers: { "Authorization" => @authorization }
      expect(response.status).to eq 200
      response_body = JSON.parse(response.body)['checker']
      expect(@user.checkers.count).to eq 1
      expect(response_body['checkin']).to_not eq nil
      expect(response_body['checkout']).to eq nil
    end

    it 'checkin in new checker' do
      check = FactoryBot.create(:checker, checkin: Time.now - 3.hours, checkout: Time.now, user: @user)
      put '/check', params: {}, headers: { "Authorization" => @authorization }
      expect(response.status).to eq 200
      expect(@user.checkers.count).to eq 2
      response_body = JSON.parse(response.body)['checker']
      expect(response_body['checkin']).to_not eq nil
      expect(response_body['checkout']).to eq nil
    end

    it 'checkout in old checker' do
      check = FactoryBot.create(:checker, checkin: Time.now - 3.hours, checkout: nil, user: @user)
      put '/check', params: {}, headers: { "Authorization" => @authorization }
      expect(response.status).to eq 200
      expect(@user.checkers.count).to eq 1
      response_body = JSON.parse(response.body)['checker']
      expect(response_body['checkin']).to_not eq nil
      expect(response_body['checkout']).to_not eq nil
    end
  end
end
