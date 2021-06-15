module Links
  class Stats
    def self.get_stats(link)
      LinkStat.where link: link
    end

    def self.add_view(link, ip)
      LinkStat.transaction do
        stat = LinkStat.find_or_initialize_by link: link, ip_address: ip
        stat.views += 1
        stat.save
      end
    end
  end
end