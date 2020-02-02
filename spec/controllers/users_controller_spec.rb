require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #show' do
    let(:user) { FactoryBot.create(:user, username: 'Max') }

    def do_request(params = nil)
      get :show, params: params
    end

    before do
      do_request(id: user.id)
    end

    it 'renders user detail page' do
      expect(assigns(:user)).to eq(user)
    end
  end

  describe 'POST #update' do
    let!(:user) { FactoryBot.create(:user, username: 'Max') }
    let(:user_params) do
      {
        id: user.id,
        user: {
          username: 'Max Testing',
          email: 'email_testing@example.com'
        }
      }
    end

    def do_request(params = nil)
      post :update, params: params
    end

    before do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in(user)

      do_request(user_params)
    end

    context 'when user params is valid' do
      it 'updates user info with new values' do
        expect(response).to redirect_to(user)
        expect(flash[:notice]).not_to eq(nil)
        expect(user.reload.username).to eq(user_params.dig(:user, :username))
      end
    end

    context 'when user params is invalid' do
      it 'renders edit user page' do

      end
    end
  end
end
