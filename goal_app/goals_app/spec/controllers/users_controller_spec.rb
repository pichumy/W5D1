require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #create" do
    context 'with invalid params' do
      it 'validates the presence of username and password' do
        post :create, params: {user: {blah: 'this is improper data'}}
        expect(response).to render_template('new')
        expect(flash[:errors]).to be_present
      end
    end
    context 'with valid params' do
      it 'redirects to the user show page' do
        post :create, params: {user: {username: 'User', password: 'password'}}
        expect(response).to redirect_to(user_url(User.last))
      end
    end
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    # it "returns http success" do
    #   get :show
    #   expect(response).to have_http_status(:success)
    # end
  end

end
