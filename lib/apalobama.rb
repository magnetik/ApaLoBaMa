require 'apalobama/version'
require 'commander/import'
require 'yaml'
require 'amphibian'

program :version, '0.0.1'
program :description, 'Manage mod-proxy-balancer'

module Apalobama
	class App
		def run
			program :name, "apalobama"
			program :version, apalobama::VERSION
			program :description, "Manage mod-proxy-balancer"
			
			default_command :help
			
			command :help do |c|
			end
			
			command :list do |c| 
				c.action do |args, options|
					url = args.first
					abort('Give an url') if url.nil?
				end
			end
		end
	end
end
