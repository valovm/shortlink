module Links
  class GetLink
    def self.call(code, ip = nil)
      link = Link.find_by code: code
      Stats.add_view(link, ip) if link && ip

      link
    end
  end
end