require 'uri'
require 'yaml'

require 'apalobama/version'

require 'thor'
require 'amphibian'

module Apalobama
	class CLI < Thor
		def initialize(*args)
			super
			@amphibians = Hash.new
			@config = YAML::load(File.open('/etc/apalobama.yml'))
		end

		desc "list URL|GROUP", "List host of given group or URL"
		def list(element)
			loadElement element
			@amphibians.each do |url, amphibian|
				puts "Hosts statuses for the balancer: #{url}"
				amphibian.hosts_with_status.each do |balancer, status|
					puts "  - #{balancer} => #{status}"
				end
			end
		end
		
		desc "disable URL|GROUP HOST", "Disable host for the given group or URL"
		def disable(element, host)
			loadElement element
			@amphibians.each do |url, amphibian|
				if not amphibian.hosts_with_status.has_key?(host)
					raise Thor::Error, "Host '#{host}' not in balancer #{url}"
				else if amphibian.hosts_with_status
				end
			end
		end
		
		private
		
		def loadElement(element)
			if element =~ /^#{URI::regexp}$/
				@amphibians.store(element, Amphibian::BalancerManager.new(element, true))
			else
				if @config.has_key?('groups') and @config['groups'].has_key?(element)
					@config['groups'][element].each do |url|
						@amphibians.store(url, Amphibian::BalancerManager.new(url, true))
					end
				else
					raise Thor::Error, "Unknown group name: #{element}"
				end
			end
		end
	end
end
