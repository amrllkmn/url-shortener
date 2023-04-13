class UrlsController < ApplicationController
    def index
        render json: {"message": "Hello World!"}, status: :ok
    end

    def shorten
        @url = params[:url]
        @slug = params[:slug]
        @created_url = Url.shorten_url(@url, @slug, request.host_with_port)
        if @created_url.nil?
            render json: {"message": "Something went wrong"}, status: :internal_error
        end
        render json: {"message": "Created", "short_url": @created_url}, status: :created
    end

    def show
        url = Url.find_by(slug: params[:slug])
        response_body = AbstractApi.get_location(client_ip).body
        puts response_body
        if url.nil?
            render json: {"message": "Not found"}, status: :not_found
        else
        redirect_to url.target_url
        end
    end

    private

    def client_ip
        if request.ip == "::1"
            return "14.192.212.14"
        end
        request.ip
    end 
    
end