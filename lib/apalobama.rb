require 'uri'
require 'yaml'

require 'apalobama/version'

require 'thor'
require 'amphibian'

module Apalobama
	class CLI < Thor
		def initialize()
			@amphibians = Hash.new
			@config = YAML::load(File.open('/etc/apalobama.yml'))
		end

		desc "list URL|GROUP", "List host of given group or URL"
		def list(element)
			loadElement(element)
			@amphibians.each do |url, amphibian|
				puts amphibian.hosts_with_status
			end
		end
		
		desc "disable URL|GROUP HOST", "Disable host for the given group or URL"
		def disable(element, host)
			loadElement(element)
			@amphibians.each do |url, amphibian|
				amphibian.disable_host host
			end
		end
		
		private
		
		def loadElement(element)
			if url =~ /^#{URI::regexp}$/
				@amphibians.store(url, Amphibian::BalancerManager.new(url))
			else
				if @config.has_key?(:groups) and @config.has_key?(element)
					@config[:groups][element].each do |url|
						@amphibians.store(url, Amphibian::BalancerManager.new(url))
					end
				else
					raise Thor::Error, "Unknown group name"
				end
			end
		end
	end
end
