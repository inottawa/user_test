module Api
  module V1
    class UsersController < ApplicationController

      before_filter :authenticate_user!

      allow_oauth! :except => :delete

      respond_to :json

      def show
      	@user =   current_user if params[:id] == 'me'
        @user ||= User.find(params[:id])
        respond_with @user
      end

      def update
        @user = current_user
        @user.update_attributes(user_params)
        respond_with @user
      end

      def user_params
        params.require(:user).permit(:name, :email, :twitter, :postalcode)
      end
      
    end
  end
end