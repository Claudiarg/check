class CheckerController < ApplicationController
  before_action :authorized_request

  #put /checker
  def check
    checkers = Checker.where(user_id: @current_user.id).order(created_at: :desc)
    checker = checkers.first
    if checker.nil? || (checker.checkin != nil && checker.checkout != nil)
      checker = Checker.create(checkin: Time.now, user: @current_user)
    else
      checker.update(checkout: Time.now)
    end
    render json: { checker: checker.slice('checkin', 'checkout', 'user_id') }, status: :ok
  end

  private

  def checkers_params
    params.permit(:id)
  end
end
