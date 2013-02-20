namespace :dbtools do
  desc "Backup database to CSV file"
  task :backup => :environment do
    require "repdatabase"
#    puts 'Backup Class Codes'
#    FileUtils.rm_rf 'class_codes.csv' if File.exists? 'class_codes.csv'
#    RepDatabase.to_file(ClassCode)
#
#    puts 'Backup Properties'
#    FileUtils.rm_rf 'properties.csv' if File.exists? 'properties.csv'
#    RepDatabase.to_file(Property)

    puts 'Backup Details'
    FileUtils.rm_rf 'details.csv' if File.exists? 'details.csv'
    RepDatabase.to_file(Detail)


#    puts 'Backup Owner'
#    FileUtils.rm_rf 'owners.csv' if File.exists? 'owners.csv'
#    RepDatabase.to_file(Owner)
#
#    puts 'Backup Myprops'
#    FileUtils.rm_rf 'myprops.csv' if File.exists? 'myprops.csv'
#    RepDatabase.to_file(Myprop)
#   
#    puts 'Backup Users'
#    FileUtils.rm_rf 'users.csv' if File.exists? 'users.csv'
#    RepDatabase.to_file(User)
    
  end

  desc "Restore database from CSV file"
  task :restore => :environment do
    require "repdatabase"
#    puts 'Restore ClassCodes'
#    RepDatabase.from_file(ClassCode)
#    puts 'Restore Owners'
#    RepDatabase.from_file(Owner)
#    puts 'Restore Properties'
#    RepDatabase.from_file(Property)
    puts 'Restore Details'
    RepDatabase.from_file(Detail)
#    puts 'Restore the relationships'
    RepDatabase.repair_relationship(Detail, Property)
    RepDatabase.repair_relationship(Owner, Property)
    
    
  end
end
      
