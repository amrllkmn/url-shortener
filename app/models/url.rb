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
end
