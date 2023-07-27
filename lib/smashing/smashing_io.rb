# frozen_string_literal: true

module Smashing
  class SmashingIO # rubocop:disable Style/Documentation
    def initialize(argv)
      @argv = argv
    end

    def call
      result
    end

    private

    attr_reader :argv

    def result
      case argv
      in ['-month', /^(0[1-9]|1[0-2])\d{4}$/ => month, '-resolution', /^\d+x\d+$/ => resolution]
        SmashingDownloader.new(month: month, resolution: resolution).call
      else
        text_error
      end
    end

    def text_error
      puts <<~HEREDOC
        |Invalid input :(=========================================|
        |                                                         |
        |  Specify the month in the format MMYYYY (e.g., 022018)  |
        |  Specify the wallpaper resolution (e.g., 640x480)       |
        |  Example: ./smashing —month 022018 —resolution 640x480  |
        |                                                         |
        |=========================================================|
      HEREDOC
    end
  end
end
