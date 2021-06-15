require 'rails_helper'

RSpec.describe 'Api::V1::UrlsController', type: :request do

  let(:invalid_link) { 'sdfsdf sfa' }
  let(:valid_link) { 'https://ruby-doc.org/stdlib-2.5.1/libdoc/uri/rdoc/URI.html' }
  let(:valid_link2) { 'http://www.youtube.com/'}

  describe 'POST /api/v1/urls' do

    before do
      post '/api/v1/urls', params: params
    end

    describe 'Valid Link' do
      let(:params) { { url: valid_link } }
      it{ expect(response).to have_http_status(200) }
    end

    describe 'Valid Link' do
      let(:params) { { url: invalid_link } }
      it{ expect(response).to have_http_status(400) }
    end
  end

  describe 'Get /api/v1/urls/:code' do

    before do
      get "/api/v1/urls/#{code}"
    end

    describe 'ok' do
      let(:code) { Links::GetCode.new.call valid_link }
      it{ expect(response).to have_http_status(200) }
    end

    describe 'Not found' do
      let(:code) { '12345677' }
      it{ expect(response).to have_http_status(404) }
    end

  end

  describe 'Stats' do

    before do
      get "/api/v1/urls/#{code}/stats"
    end

    describe 'ok' do
      let(:code) { Links::GetCode.new.call valid_link }
      it{ expect(response).to have_http_status(200) }
    end

    describe 'Not found' do
      let(:code) { '12345677' }
      it{ expect(response).to have_http_status(404) }
    end

  end
end
