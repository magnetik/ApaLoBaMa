require 'apalobama/version'
require 'thor'
require 'yaml'
require 'amphibian'

module Apalobama
	class CLI < Thor
		desc "list", "List host of given group"
		method_option :group, :aliases => "-g", :desc => "Do the action on the whole group"
		def list(url = nil)
			group = options[:group]
			if group and url.nil?
			end
		end
	end
end
