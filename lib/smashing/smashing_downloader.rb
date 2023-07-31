# frozen_string_literal: true

module Smashing
  class SmashingDownloader # rubocop:disable Style/Documentation
    URL      = 'https://www.smashingmagazine.com'

    def initialize(params)
      @month      = params[:month]
      @resolution = params[:resolution]
      @date       = Date.parse("01-#{@month[...2]}-#{@month[2..]}")
    end

    def call
      download_wallpapers
    end

    private

    attr_reader :month, :resolution, :date

    def download_wallpapers
      dir = "#{date.strftime('%B')} #{date.year}/"
      FileUtils.mkdir_p(dir) unless File.directory?(dir)

      wallpaper_links.each do |url|
        FileUtils.mv(Down.download(url).path, "#{dir}#{File.basename(url)}")
      end
    end

    def wallpaper_links
      full_path
        .then(&URI.method(:parse))
        .then(&Net::HTTP.method(:get))
        .then(&Nokogiri::HTML.method(:parse))
        .then(&method(:process_html))
    end

    def full_path
      month_number = format('%02d', (date.month == 1 ? 12 : date.month - 1))
      "#{URL}/#{date.year}/#{month_number}/desktop-wallpaper-calendars-#{date.strftime('%B').downcase}-#{date.year}/"
    end

    def process_html(doc)
      doc.css('a').filter_map do |tag|
        tag['href'] if tag.xpath('text()').to_s == resolution
      end
    end
  end
end
