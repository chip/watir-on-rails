class WatirGenerator < Rails::Generator::NamedBase
  def banner
    "Usage: #{$0} #{spec.name} testname [options]"
  end
  
  def manifest
    record do |m|
      m.class_collisions class_path, class_name, "#{class_name}Test"
      m.directory File.join("test/watir", class_path)      
      m.template "watir_test.rb", File.join("test/watir", class_path, "#{file_name}_test.rb")
    end
  end
end