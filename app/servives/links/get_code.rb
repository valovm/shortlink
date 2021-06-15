module Links
  class GetCode
    def call(link)
      raise Error, 'invalid_link' unless check_url link

      en_link = Link.find_by url: URI(link).to_s
      return en_link.code if en_link

      generate_and_save(link).code
    end

    private

    def generate_and_save(link)
      code =nil
      Links.config(:COUNT_TRY_GENERATE_CODE).times do
        code = generate_code(link)
        break unless Link.find_by code: code
      end
      Link.create!(code: code, url: link) if code
    end

    def check_url(link)
      URI.parse(link)
    rescue => e
      false
    end

    def generate_code(link)
      Digest::SHA256.hexdigest(link)[0... Links.config(:SHORT_LINK_WIDTH)]
    end
  end
end