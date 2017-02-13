class Api::V1::LinksController < ApplicationController
  def index
    render json: Link.all
  end

  def update
  end
end
