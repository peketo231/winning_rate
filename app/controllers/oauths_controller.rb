class OauthsController < ApplicationController
  skip_before_action :require_login, raise: false

  def oauth
    login_at(params[:provider])
  end

  def callback
    provider = params[:provider]
    if params[:denied].present?
      redirect_to root_path, success: 'ログインをキャンセルしました'
      return
    end
    unless (@user = login_from(provider))
      @user = create_from(provider)
      reset_session
      auto_login(@user)
    end
    redirect_to battle_records_path, success: "#{provider.titleize}でログインしました"
  end
end
