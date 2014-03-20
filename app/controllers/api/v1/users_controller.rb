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
        @user.update_attributes(params[:user])
        respond_with @user
      end
      
    end
  end
end