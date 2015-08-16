require 'new_relic/agent/method_tracer'

DependencyDetection.defer do
  @name = :elasticsearch

  depends_on do
    defined?(::Elasticsearch::Model) &&
    !NewRelic::Control.instance['disable_elasticsearch'] &&
    ENV['NEWRELIC_ENABLE'].to_s !~ /false|off|no/i
  end

  executes do
    NewRelic::Agent.logger.info 'Installing ElasticSearch Instrumentation'
  end

  executes do
    require 'new_relic/agent/datastores'
  end
end
