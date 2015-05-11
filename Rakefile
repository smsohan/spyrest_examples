require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['**/*_test.rb']
  t.verbose = true
end

task :default => :test

task :hit do
  ENV['REAL'] = '1'
  Rake::Task['test'].invoke
end