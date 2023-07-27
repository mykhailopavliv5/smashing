# frozen_string_literal: true

require 'smashing/smashing_io'
require 'smashing/smashing_downloader'

RSpec.describe Smashing::SmashingIO do
  describe '#call' do
    context 'when valid arguments are provided' do
      let(:valid_month) { '022018' }
      let(:valid_resolution) { '640x480' }
      let(:valid_argv) { ['-month', valid_month, '-resolution', valid_resolution] }
      let(:expected_downloader) { instance_double(Smashing::SmashingDownloader) }

      it 'calls SmashingDownloader with the correct month and resolution' do
        expect(Smashing::SmashingDownloader).to receive(:new).with(month: valid_month, resolution: valid_resolution).and_return(expected_downloader)
        expect(expected_downloader).to receive(:call)

        Smashing::SmashingIO.new(valid_argv).call
      end
    end

    context 'when invalid arguments are provided' do
      let(:invalid_argv) { ['-invalid_arg'] }

      it 'prints the error message' do
        expect(STDOUT).to receive(:puts).with(<<~HEREDOC)
          |Invalid input :(=========================================|
          |                                                         |
          |  Specify the month in the format MMYYYY (e.g., 022018)  |
          |  Specify the wallpaper resolution (e.g., 640x480)       |
          |  Example: ./smashing —month 022018 —resolution 640x480  |
          |                                                         |
          |=========================================================|
        HEREDOC

        Smashing::SmashingIO.new(invalid_argv).call
      end
    end
  end
end
