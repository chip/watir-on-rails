namespace :test do
  desc "Run the Watir tests in test/watir"
  Rake::TestTask.new(:watir => "db:test:prepare") do |t|
    t.libs << "test"
    t.pattern = 'test/watir/**/*_test.rb'
    t.verbose = true
  end  
end
