class NotificationsController < ApplicationController
  def create
    NotificationsMailer.notify(params[:email]).deliver_later
  end
end
