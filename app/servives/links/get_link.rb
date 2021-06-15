module Links
  class GetLink

    def self.call(code)
      link = Link.find_by code: code
      raise LinkNotFound unless link

      link
    end
  end
end