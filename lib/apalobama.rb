require 'apalobama/version'
require 'thor'
require 'yaml'
require 'amphibian'

module Apalobama
	class CLI < Thor
		attr_reader :current_amph

		desc "list", "List host of given group"
		method_option :group, :aliases => "-g", :desc => "Do the action on the whole group"
		def list(url)
			@current_amph = Amphibian::BalancerManager.new(url)
			puts @current_amph.hosts_with_status
		end
		def listGroup(groupName)
		end
	end
end
