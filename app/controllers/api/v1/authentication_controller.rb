module Api
  module V1
    class AuthenticationController < ApplicationController
     skip_before_action :authenticate_request

      def authenticate
        command = AuthenticateUser.call(params[:email], params[:password])

        if command.success?
          if User.where(email: params[:email]).first.confirmed
            render json: { auth_token: command.result }
          else
            render json: { error: 'Account not yet confirmed.'}, status: :unauthorized
          end

        else
           render json: { error: command.errors }, status: :unauthorized
        end
      end
    end
  end
end