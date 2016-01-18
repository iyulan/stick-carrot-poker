class SessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]

  def new
  end

  def create
    if login(params[:email], params[:password], params[:remember_me])
      flash[:success] = t('sessions.create.success')
      redirect_back_or_to authenticated_root_path
    else
      flash[:warning] = t('sessions.create.warning')
      render :new
    end
  end

  def destroy
    logout
    flash[:success] = t('sessions.destroy.success')
    redirect_to sign_in_path
  end
end
