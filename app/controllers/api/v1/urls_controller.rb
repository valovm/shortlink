class Api::V1::UrlsController < ApplicationController

  # GET /api/v1/url
  def show
    link = Links::GetLink.new.call(params[:id])
    redirect_to link
  end
  # POST /api/v1/url
  def create
    code = Links::GetCode.new.call(url)
    render json: { short_link: code }, status: 200
  end
  # POST /api/v1/url/:code/stats
  def stats
    link = Link.find_by code: params[:id]
    code = Links::Stats.get_stats link
    render json: { short_link: code }, status: 200
  end

  private

  def url_params
    params.permit(:url)
  end
end
