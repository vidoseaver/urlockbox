class Api::V1::LinksController < ApplicationController
  def index
    render json: Link.all
  end

  def update
    @link = Link.find(link_params[:id])
    return invalid_url_error unless Link.valid_url?(link_params[:url])
    return no_title_error unless has_title?
    @link.update_attributes(link_params)
    render json: @link
  end

  private

      def link_params
        JSON.parse(params.require(:payload), symbolize_names: true)
      end

      def invalid_url_error
        render json: "Invalid Url Bro!"
      end

      def no_title_error
        render json: "You need a title Bro!"
      end

      def has_title?
        link_params[:title].chomp != "" ? true : false
      end
end
