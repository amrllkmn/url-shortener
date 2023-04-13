class Url < ApplicationRecord
    before_validation :generate_slug
    validates_presence_of :target_url
    validates :target_url, format: URI::regexp(%w[http https])
    validates_uniqueness_of :slug
  
    def generate_slug
        self.slug = SecureRandom.uuid[0..5] if self.slug.nil? || self.slug.empty?
        true
    end

    def self.shorten_url(url, slug= '', request_url)
        link = Url.where(target_url: url, slug: slug).first
        if link
            return "#{request_url}/urls/#{link.slug}"
        end

        link = Url.new(target_url: url, slug: slug)
        if link.save
            return "#{request_url}/urls/#{link.slug}"
        end

        Url.shorten(url, slug+SecureRandom.uuid[0..5], request_url)
    end

    def self.update_url(slug, geolocation)
        current_time = Time.now.strftime("%Y-%m-%d %H:%M:%S %z")
        url = Url.find_by(slug: slug)
        if url
            url.times_clicked += 1
            updated_timestamp = JSON.parse(url.click_timestamp)
            updated_timestamp[url.times_clicked] = current_time
            updated_timestamp = JSON.generate(updated_timestamp)

            updated_origin = JSON.parse(url.origin)
            updated_origin.append(geolocation)
            updated_origin = JSON.generate(updated_origin)

            url.click_timestamp = updated_timestamp
            url.origin = updated_origin

            return url if url.save
        end
    end
end
