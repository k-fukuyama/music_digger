class Api::V1::GrammiesController < ApplicationController
  def index
  end

  def create
    grammy = Grammy.new(grammy_params)
    if grammy.save
      head :ok
    else
      render json: e.message, status: 500
    end
  end

  private

  def grammy_params
     params.require(:grammy).permit(:artist_id, :song_id, :genre_id, :grammy_type, :year)
  end
end
