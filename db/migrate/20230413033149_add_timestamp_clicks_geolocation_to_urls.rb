class AddTimestampClicksGeolocationToUrls < ActiveRecord::Migration[6.1]
  def change
    add_column :urls, :times_clicked,   :integer, :default => 0
    add_column :urls, :click_timestamp, :string,  :default => "{}"
    add_column :urls, :origin,          :string,  :default => "[]"
  end
end
