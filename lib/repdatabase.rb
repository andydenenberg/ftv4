module RepDatabase
  
  def self.to_csv(model)
    attribs = model.attributes.keys 
    output = ''
    attribs[0..-2].each do |a|
      output << model[a].to_s.delete("\n").gsub(',','_') + ', '
    end
      output << model[attribs.last].to_s.delete("\n").gsub(',','_')
  end
  
  def self.from_csv(line, model)
    require 'csv'
    attribs = model.new.attributes.keys - ['id']
    record = model.new
    data = CSV.parse(line)[0].drop(1) # drop the old id
    attribs.each_with_index do |att,i|
      record[att] = data[i].strip
    end
    return record
  end
  
  def self.to_file(model)
    File.open(model.table_name + '.csv', 'w') do |f2|  
      model.all.each_with_index do |prop,i|
          puts i
          f2.puts self.to_csv(prop)
      end
    end
    return nil
  end
    
  def self.from_file(model)
    require 'csv'
    attribs = model.new.attributes.keys 
    i = 0
    File.open(model.table_name + '.csv', 'r') do |f1|  
      while line = f1.gets # and i < 100
        i += 1
        record = self.from_csv(line, model)
         record.save! 
        puts i.to_s # + ' - ' + record.inspect        
      end  
    end  
  end

  def self.repair_relationship(dependent_model, independent_model)
    independent_model.all.each_with_index do |im, i|
      key = "#{independent_model}".downcase + '_id'
      dm = dependent_model.find_by_pin(im.pin)
      dm["#{key}"] = im.id
      dm.save
      puts i.to_s + ' - ' + dm.pin + ' - ' + im.pin
    end
  end
  
  def self.match_owner
     Owner.all.each do |l|
       prop = Property.where(:street => l.cc_address.downcase.titleize, :city => l.cc_city_state_zip.downcase.titleize )
       l.property_id = prop[0].id
       puts prop.count.to_s + ' - ' + prop[0].street + ' - ' + prop[0].city
     end   
  end


# dump_city and get_city methods are to be used to extract and insert specific city property and detail records
# run 'rails console test'
# 1.9.3-p327 :001 > RepDatabase.dump_city('Winnetka')
# 1.9.3-p327 :001 > RepDatabase.get_city('Winnetka')
# 1.9.3-p327 :001 > RepDatabase.repair_relationship(Detail, Property)
#
  def self.dump_city(city)
    f1 = File.open(city + '_detail_dump.csv', 'w')  
    File.open(city + '_property_dump.csv', 'w') do |f2|  
      Property.where(:city => city).each_with_index do |prop,i|
          puts i
          f1.puts self.to_csv(prop.detail)
          f2.puts self.to_csv(prop)
      end
    end
    return nil
  end
  
  def self.get_city(city)
    require 'csv'
    property_attribs = Property.new.attributes.keys 
    detail_attribs = Detail.new.attributes.keys 
    i = 0
    f1 = File.open(city + '_detail_dump.csv', 'r')  
    File.open(city + '_property_dump.csv', 'r') do |f2|  
      while line = f2.gets 
        i += 1
        prop = self.from_csv(line, Property)
         prop.save! 
        line = f1.gets
        detail = self.from_csv(line, Detail)
         detail.save! 
        
        puts i.to_s # + ' - ' + record.inspect        
      end  
    end  
  end
  

end