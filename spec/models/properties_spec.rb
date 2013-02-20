require 'spec_helper'
require 'repdatabase'

describe Property do

  it "should return array of property values" do
    property = Property.new
     (property.pin == nil) .should be_true
  end
  
  it 'should convert a model object to a csv separated list' do
    property = RepDatabase.to_csv(Property.first)
    first_csv = "1, 05-21-100-003-0000, 5, 21, 100, 3, 0, 588 Arbor Vitae Rd, Winnetka, USA, 60093, 42.107269, -87.7316, true, 22, 2-06, 85124, 2012-02-10 17:06:27 UTC, 2012-03-18 16:57:11 UTC, 2"
    ( property == first_csv) .should be_true
  end
  
  it 'should convert a line of csv to a model record' do
    line = File.open('properties.csv', 'r') { |f1| f1.gets }
    property = RepDatabase.from_csv(line, Property)
    ( property == Property.first ) .should be_true
  end  
  
  it 'should find the most favorable comps' do
    most_favorable = Property.most_favorable('05-21-100-003-0000')
      
    

end

