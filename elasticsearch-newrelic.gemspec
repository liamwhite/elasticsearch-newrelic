Gem::Specification.new do |s|
  s.name        = 'elasticsearch-newrelic'
  s.version     = '0.1.1'
  s.date        = '2017-02-12'
  s.summary     = "Elasticsearch instrumentation for New Relic"
  s.description = "Elasticsearch instrumentation for New Relic"
  s.authors     = ["Liam P. White"]
  s.email       = 'example@example.com'
  s.files       = ["lib/elasticsearch-newrelic.rb", "lib/elasticsearch_newrelic/instrumentation.rb", "lib/elasticsearch_newrelic/version.rb"]
  s.homepage    = 'http://example.com'
  s.license     = 'MIT'

  s.add_runtime_dependency 'elasticsearch'
  s.add_runtime_dependency 'newrelic_rpm'
end
