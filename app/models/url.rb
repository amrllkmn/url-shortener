class Url < ApplicationRecord
    validates_presence_of :target_url
    validates_uniqueness_of :short_url

    def shorten_url(original_url)
    end

end
