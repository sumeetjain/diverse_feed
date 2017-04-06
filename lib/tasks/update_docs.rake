YARD::Config.load_plugin('tomdoc')

YARD::Rake::YardocTask.new do |t|
  t.files   = ['lib/**/*.rb', 'app/**/*.rb']
end
