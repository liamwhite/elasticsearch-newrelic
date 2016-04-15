Gem::Specification.new do |s|
  s.name        = 'elasticsearch-newrelic'
  s.version     = '0.1.0'
  s.date        = '2016-04-15'
  s.summary     = "Elasticsearch instrumentation for New Relic"
  s.description = "Elasticsearch instrumentation for New Relic"
  s.authors     = ["Liam P. White"]
  s.email       = 'example@example.com'
  s.files       = ["lib/elasticsearch-newrelic.rb", "lib/elasticsearch_newrelic/instrumentation.rb", "lib/elasticsearch_newrelic/version.rb"]
  s.homepage    = 'http://example.com'
  s.license     = 'MIT'

  s.add_runtime_dependency 'elasticsearch', ['~> 1.0']
  s.add_runtime_dependency 'newrelic_rpm', ['~> 3.15']
end
