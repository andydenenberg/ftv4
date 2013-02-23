class Property < ActiveRecord::Base
  attr_accessible :updated_at, :created_at, :area, :assessed_value, :block, :category, :city, :class_code, :country, :gmaps, :latitude, :longitude, :neighborhood, :parcel, :pin, :street, :subdivision, :unit, :zip
  has_one :detail
  
  # setup scope for city, block
  def self.most_favorable(property, count, multiplier)
    self.find(:all, :include => :detail, :conditions => 
    ['assessed_value > :low_av and assessed_value < :hi_av and
      details.building_size < :hi_bs and details.building_size > :low_bs and
      details.age < :hi_age and details.age > :low_age and
      properties.city = :town' ,
       { :town => property.city,
         :low_av => property.assessed_value * (1 - multiplier), :hi_av => property.assessed_value  * (1 + multiplier),
         :low_bs => property.detail.building_size * (1 - multiplier),  :hi_bs => property.detail.building_size * (1 + multiplier),
         :low_age => property.detail.age * (1 - multiplier), :hi_age => property.detail.age * (1 + multiplier) } 
      ], :order => 'details.building_value_ratio asc', :limit => count )
    # return 10.times.collect { |i| i }
  end
  
end
