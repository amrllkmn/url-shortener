require 'net/http'
require 'uri'

class AbstractApi
    # This service calls the geolocation API
    def self.get_location(ip_address)
        uri = URI("https://ipgeolocation.abstractapi.com/v1/?api_key=#{ENV["ABSTRACT_API_KEY"]}&ip_address=#{ip_address}&fields=city,region,country")
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_PEER

        request =  Net::HTTP::Get.new(uri)

        response = http.request(request)
        puts "Status code: #{ response.code }"
        puts "Response body: #{ response.body }"
        return response
    rescue StandardError => error
        puts error
        puts "Error (#{ error.message })"
    end

end