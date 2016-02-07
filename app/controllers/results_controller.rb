class ResultsController < ApplicationController
  def index
    @results = current_user.results.for(Date.today)
    @acts = current_user.acts
  end

  def data
    date = params[:date] || Date.today
    render json: current_user.results.for(date)
  end

  def create
    @result = Result.new(result_params)

    if @result.save
      render json: @result
    else
      render json: @result.errors, status: :unprocessable_entity
    end
  end

  def update
    @result = Result.find(params[:id])
    if @result.update(result_params)
      render json: @result
    else
      render json: @result.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @result = Result.find(params[:id])
    @result.destroy
    head :no_content
  end

  private

  def result_params
    params.require(:result).permit(:date, :act_id)
  end
end
