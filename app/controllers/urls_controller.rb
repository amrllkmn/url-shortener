class UrlsController < ApplicationController
    def index
        render json: {"message": "Hello World!"}, status: :ok
    end

    def shorten
        @url = params[:url]
        if @url and @url.length > 0
            render json: {"message": "Created"}, status: :created
        else
            render json: {"message": "No empty URLs"}, status: :unprocessable_entity
        end
    end

    def show
        url = Url.find_by(slug: params[:slug])
        if url.nil?
            render json: {"message": "Not found"}, status: :not_found
        else
        redirect_to url.target_url
        end
    end
    
end