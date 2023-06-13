require 'rails_helper'

RSpec.describe 'User Login' do
  describe 'happy path' do
    it 'logs in a user' do
      User.create!(email: "whatever@example.com", password: "password", password_confirmation: "password")

      user_params = {
        "email": "whatever@example.com",
        "password": "password",
      }
      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v0/sessions', headers: headers, params: JSON.generate(user_params)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      user = JSON.parse(response.body, symbolize_names: true)

      expect(user).to be_a Hash
      expect(user).to have_key :data

      data = user[:data]
      expect(data).to be_a Hash
      expect(data).to have_key :id
      expect(data[:id]).to be_a String
      expect(data).to have_key :type
      expect(data[:type]).to eq('users')
      expect(data).to have_key :attributes

      attributes = data[:attributes]
      expect(attributes).to be_a Hash
      expect(attributes).to have_key :email
      expect(attributes[:email]).to be_a String
      expect(attributes).to have_key :api_key
      expect(attributes[:api_key]).to be_a String

      expect(attributes).to_not have_key :password
      expect(attributes).to_not have_key :password_digest
    end
  end

  describe 'sad path' do
    it 'returns an error if credentials are invalid' do
      User.create!(email: "whatever@example.com", password: "password", password_confirmation: "password")

      user_params = {
        "email": "whatever@example.com",
        "password": "wrongpassword",
      }
      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v0/sessions', headers: headers, params: JSON.generate(user_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(401)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to be_a Hash
      expect(error).to have_key :error
      expect(error[:error]).to eq('Invalid email or password')
    end

    it 'returns an error if email is not found' do
      User.create!(email: "whatever@example.com", password: "password", password_confirmation: "password")

      user_params = {
        "email": "whatever123@example.com",
        "password": "wrongpassword",
      }
      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v0/sessions', headers: headers, params: JSON.generate(user_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(401)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to be_a Hash
      expect(error).to have_key :error
      expect(error[:error]).to eq('Invalid email or password')
    end

    it 'returns an error if email and/or password is blank' do
      user_params = {
        "email": "",
        "password": "", 
        "password_confirmation": ""
      }
      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v0/users', headers: headers, params: JSON.generate(user_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(422)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to be_a Hash
      expect(error).to have_key :error
      expect(error[:error]).to eq("Validation failed: Email can't be blank, Password can't be blank")
    end
  end
end
