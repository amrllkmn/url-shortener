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

    
end