class ActsController < ApplicationController
  def index
    @acts = current_user.acts
  end

  def create
    @act = Act.new(act_params)
    @act.user_id = current_user.id

    if @act.save
      render json: @act
    else
      render json: @act.errors, status: :unprocessable_entity
    end
  end

  def update
    @act = Act.find(params[:id])
    if @act.update(act_params)
      render json: @act
    else
      render json: @act.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @act = Act.find(params[:id])
    @act.destroy
    head :no_content
  end

  private

  def act_params
    params.require(:act).permit(:title, :points)
  end
end
