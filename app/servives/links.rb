module Links

  @@default_config = {
      SHORT_LINK_WIDTH: 5,
      COUNT_TRY_GENERATE_CODE: 2
  }

  def config(key)
    @@default_config[key]
  end

end