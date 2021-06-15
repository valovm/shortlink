require 'rails_helper'

RSpec.describe Links do

  let(:invalid_link) { 'sdfsdf sfa' }
  let(:valid_link) { 'https://ruby-doc.org/stdlib-2.5.1/libdoc/uri/rdoc/URI.html' }
  let(:valid_link2) { 'http://www.youtube.com/'}

  let(:get_link) { Links::GetLink }
  let(:get_code) { Links::GetCode.new }

  describe 'Get Code for ShortLink' do
    it 'valid url' do
      code = get_code.call(valid_link)
      expect(code.length).to eq(5)
      expect(get_code.call(valid_link)).to eq(code)

      expect(get_code.call(valid_link2)).not_to eq(code)
    end

    it 'not valid url' do
      expect{ get_code.call(invalid_link) }.to raise_error "invalid_link"
    end

  end

  describe 'Stats' do

    let(:code) { get_code.call valid_link }
    let(:link) { Links::GetLink.call code }
    let(:ip_address) { '2.46.45.456'}
    let(:ip_address2) { '1.23.45.456'}

    it  do
      2.times{  Links::Stats.add_view(link, ip_address2) }
      5.times{  Links::Stats.add_view(link, ip_address) }

      expect(link.url).to eq(valid_link)
      expect(link.url).not_to eq(valid_link2)
      expect(LinkStat.where(link: link).count).to eq(2)
      expect(LinkStat.where(link: link, ip_address: ip_address ).sum(:views)).to eq(5)
      expect(LinkStat.where(link: link, ip_address: ip_address2 ).sum(:views)).to eq(2)
    end

  end

end