class Url < ApplicationRecord
    before_validation :generate_slug
    validates_presence_of :target_url
    validates :target_url, format: URI::regexp(%w[http https])
    validates_uniqueness_of :slug
  
    def generate_slug
        self.slug = SecureRandom.uuid[0..5] if self.slug.nil? || self.slug.empty?
        true
    end

    def self.shorten_url(url, slug= '', title)
        link = Url.where(target_url: url, slug: slug).first
        return "#{ENV["HOST_URL"]}/#{link.slug}" if link
        
        link = Url.new(target_url: url, slug: slug, title: title)
        return "#{ENV["HOST_URL"]}/#{link.slug}" if link.save
        
        Url.shorten_url(url, slug+SecureRandom.uuid[0..2])
    end

    def self.update_url(slug, geolocation)
        begin            
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
        rescue ActiveRecord::RecordNotFound
            return nil
        end
    end

    def self.get_report(id)
        begin            
            url = Url.find(id)
            if url
                data = self.process_data(url)
                return data
            end
        rescue ActiveRecord::RecordNotFound
            return nil
        end
    end

    def self.all_urls_report
        urls = Url.all()
        data = []
        urls.each do |url|
            processed_data = process_data(url)
            data.append(processed_data)
        end
        return data
    end

    private

    def self.process_data(url)
        data = {}
        url.attributes.each do |attr, value|
            key = attr.to_s
            if key == "click_timestamp" or key == "origin"
                data[key] = JSON.parse(value)
            else
                data[key] = value
            end
        end
        data["short_url"] = "#{ENV["HOST_URL"]}/#{url.slug}"
        return data
    end
end
