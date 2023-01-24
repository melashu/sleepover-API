class ApplicationController < ActionController::API
  include JsonWebToken

  before_action :authenticate_request
  helper_method :current_user

  private

  def authenticate_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header # rubocop:disable Style/RedundantArgument
    decoded = jwt_decode(header)
    @current_user = User.find(decoded[:user_id])
  rescue JWT::ExpiredSignature
    render json: { error: 'Login required. token expired' }, status: :unauthorized
  rescue StandardError
    render json: { error: 'unauthorized' }, status: :unauthorized
  end

  attr_reader :current_user
end
