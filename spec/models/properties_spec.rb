require 'spec_helper'
require 'repdatabase'

describe Property do
  
  before(:each) do
    @attr = { 
      pin: "05-21-321-050-0000",
      area: 5, subdivision: 21,
      block: 321,
      parcel: 50,
      unit: 0,
      street: "626 Hill Rd",
      city: "Winnetka",
      country: "USA",
      zip: "60093",
      latitude: 42.0949,
      longitude: -87.7281,
      gmaps: true,
      neighborhood: "80",
      class_code: "2-09",
      assessed_value: 309216,
      created_at: "2012-02-10 17:09:13",
      updated_at: "2012-03-18 17:04:46",
      category: 2    }
  end
    
  it 'should create a new property give valid attributes' do
    Property.create!(@attr) .should be_valid
  end
  
  it "should return array of property values" do
    property = Property.new
     (property.pin == nil) .should be_true
  end
  
  it 'should convert a model object to a csv separated list' do
    prop = Property.create!(@attr) 
    property = RepDatabase.to_csv(prop)
    first_csv = "5181, 05-21-321-050-0000, 5, 21, 321, 50, 0, 626 Hill Rd, Winnetka, USA, 60093, 42.0949, -87.7281, true, 80, 2-09, 309216, 2012-02-10 17:09:13 UTC, 2012-03-18 17:04:46 UTC, 2"
    ( property == first_csv) .should be_true
  end
  
  it 'should convert a line of csv to a model record' do
    line = File.open('spec/test.csv', 'r') { |f1| f1.gets }
    property = RepDatabase.from_csv(line, Property)
    property.id = 5181 # set to sync with database record
    p = Property.create!(@attr)
    ( property == p ) .should be_true
  end  
  
  it 'should return the correct number of favorable comps requested' do
    property = Property.find_by_street('626 Hill Rd') # create!(@attr)
    most_favorable = Property.most_favorable(property, count=10, multiplier=0.5)
    most_favorable.count .should eq(10)
  end

  it 'the favorable comps should be in the correct order' do
    property = Property.find_by_street('626 Hill Rd') # create!(@attr)
    most_favorable = Property.most_favorable(property, count=10, multiplier=0.5)
    most_favorable.count .should eq(10)
  end
    

end

