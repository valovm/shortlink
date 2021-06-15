class Api::V1::UrlsController < ApplicationController

  rescue_from(Links::LinkNotFound) { render status: 404 }

  # GET /api/v1/urls
  def show
    link = Links::GetLink.call(params[:id])
    Links::Stats.add_view(link, ip_address) if link && ip_address
    render json: { short_link:  link.url }, status: 200

  end
  # POST /api/v1/urls
  def create
    code = Links::GetCode.new.call url_params[:url]
    render json: { short_code: code }, status: 200
  rescue  Links::Error => e
    render json: { error: e.message }, status: 400
  end
  # POST /api/v1/urls/:code/stats
  def stats
    link = Links::GetLink.call params[:id]
    render json: { stats: Links::Stats.get_stats(link) }, status: 200
  end

  private

  def url_params
    params.permit(:url)
  end

  def ip_address
    request.remote_ip
  end
end
