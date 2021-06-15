module Links

  @@default_config = {
      SHORT_LINK_WIDTH: 5,
      COUNT_TRY_GENERATE_CODE: 2
  }
  class Error < ::StandardError
  end

  class LinkNotFound < ::StandardError
  end

  # @param [Object] key
  def self.config(key)
    @@default_config[key]
  end

end