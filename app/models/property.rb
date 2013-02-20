class Property < ActiveRecord::Base
  attr_accessible :area, :assessed_value, :block, :category, :city, :class_code, :country, :gmaps, :latitude, :longitude, :neighborhood, :parcel, :pin, :street, :subdivision, :unit, :zip
  has_one :detail
end
