class PropertyController < ApplicationController
  
  def home
    @property = Property.find(721)
    
  end
end