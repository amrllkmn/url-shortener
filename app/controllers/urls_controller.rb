class UrlsController < ApplicationController
    before_action :validate_url, only: [:shorten]
    def index
        render json: {"message": "Hello World!"}, status: :ok
    end

    def shorten
        @url = params[:url]
        @slug = params[:slug]
        @created_url = Url.shorten_url(@url, @slug)
        if @created_url.nil?
            render json: {"message": "Something went wrong"}, status: :internal_server_error and return
        end
        render json: {"message": "Created", "short_url": @created_url}, status: :created and return
    end

    def show
        geolocation = AbstractApi.get_location(client_ip)
        @url = Url.update_url(params[:slug], geolocation)
        if @url.nil?
            render json: {"message": "Not found"}, status: :not_found and return
        else
            redirect_to @url.target_url
            return
        end
    end

    def single_report
        @url = Url.get_report(params[:id])
        if @url.nil?
            render json: {"message": "Not found"}, status: :not_found
        else
            render json: {data: @url}, status: :ok
        end
    end

    def analytics
        @data = Url.all_urls_report()
        render json: {data: @data}, status: :ok
    end

    private

    def client_ip
        if request.ip == "::1"
            return "14.192.212.14"
        end
        request.ip
    end

    def validate_url
        resp = {}
        if params[:url].empty?
            resp["message"] = "url cannot be empty"
        end

        if !params[:url].start_with?("http", "https")
            resp["message"] = "url invalid, must be provided with https://"
        end
        render json: resp, status: :unprocessable_entity if !resp["message"].nil?
    end
    
end