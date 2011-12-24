module Paperclip		
  module Storage
    module Http

      def self.extended base
				require 'open-uri'
				require 'curb'
				
				base.instance_eval do
					@http_url_upload = @options[:http_url_upload]
					@http_url_remove = @options[:http_url_remove]
					@http_params_upload = @options[:http_params_upload] || []
					@http_params_remove = @options[:http_params_remove] || []
					
					@options[:path] ||= ":attachment/:id/:style/:basename.:extension"
					@options[:url] ||= "http://localhost/#{URI.encode(@options[:path]).gsub(/&/, '%26')}"
				end
			end
						
			def exists?(style = default_style)
        if original_filename
					begin
						!!open(url(style))
					rescue
						return false
					end
        else
          false
        end				
      end			

			def to_file(style = default_style)
				return @queued_for_write[style] if @queued_for_write[style]
				open(url(style))
      end

			def flush_writes
				@queued_for_write.each do |style, file|
					options = [Curl::PostField.file('file', file.path), Curl::PostField.content('path', path(style))]
					for key,value in @http_params_upload
						options << Curl::PostField.content(key.to_s, value.to_s)
					end
					
					Curl::Easy.http_post(@http_url_upload, options)
				end
				@queued_for_write = {}
			end
			
			def flush_deletes
				@queued_for_delete.each do |path|
					options = [Curl::PostField.content('path', path)]
					for key,value in @http_params_remove
						options << Curl::PostField.content(key, value)
					end
						
					Curl::Easy.http_post(@http_url_remove, options)
				end
				@queued_for_delete = []
			end

		end
	end
end
