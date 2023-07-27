#!/usr/bin/env ruby
# frozen_string_literal: true

require 'date'
require 'net/http'
require 'nokogiri'
require 'down'
require 'fileutils'

require_relative 'smashing/smashing_downloader'
require_relative 'smashing/smashing_io'

Smashing::SmashingIO.new(ARGV).call
