Gem::Specification.new do |s|
  s.name        = 'elasticsearch-newrelic'
  s.version     = '0.0.0'
  s.date        = '2015-08-16'
  s.summary     = "ElasticSearch instrumentation for New Relic"
  s.description = "ElasticSearch instrumentation for New Relic"
  s.authors     = ["Liam P. White"]
  s.email       = 'example@example.com'
  s.files       = ["lib/elasticsearch-newrelic.rb", "lib/elasticsearch_newrelic/instrumentation.rb", "lib/elasticsearch_newrelic/version.rb"]
  s.homepage    = 'http://example.com'
  s.license     = 'MIT'

  s.add_runtime_dependency 'elasticsearch-model', ['~> 0.1']
  s.add_runtime_dependency 'newrelic_rpm', ['~> 3.12']
end
