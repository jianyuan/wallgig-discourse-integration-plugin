module Wallgig
  class UsersController < Wallgig::ApplicationController
    before_filter :set_user, only: [:show, :update, :auth_token]

    def show
      respond_with @user.to_json
    end

    def create
      @user = User.new(user_params)
      @user.save!
      respond_with @user.to_json
    end

    def update
      if @user.update(user_params)
        respond_with @user.to_json
      else
        respond_with @user.errors, status: :unprocessable_entity
      end
    end

    def auth_token
      @user.auth_token = SecureRandom.hex(16)
      @user.save!

      payload = {
        auth_token_param: Discourse.current_user_provider::TOKEN_COOKIE,
        auth_token_value: @user.auth_token
      }

      respond_with payload
    end

    private
      def set_user
        if params[:using_main_id].present? && params[:using_main_id] == 'true'
          @user = Oauth2UserInfo.find_by!(provider: 'wallgig', user_id: params[:id]).user
        else
          @user = User.find(params[:id])
        end
      end

      def user_params
        params.require(:user).permit(:username, :email, :name)
      end
  end
end