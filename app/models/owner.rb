class Owner < ActiveRecord::Base
  attr_accessible :cc_name, :cc_tax_year, :cc_address, :cc_city_state_zip, :recent_sale_price, :recent_sale_date, :recent_seller, :recent_buyer, :property_id, :pin
  
  belongs_to :property 
end