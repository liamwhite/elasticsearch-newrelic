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

    ::Elasticsearch::Model::Searching::SearchRequest.class_eval do
      # Method to hijack
      execute_method = :execute!

      def execute_with_newrelic_trace
        index_name = definition[:index] || 'nil'
        result = nil
        callback = proc do |res, metric, elapsed|
          NewRelic::Agent::Datastores.notice_statement(index_name, elapsed)
          result = res
        end

        NewRelic::Agent::Datastores.wrap("ElasticSearch", "search", index_name, callback) do
          execute_without_newrelic_trace
        end
        result
      end

      alias_method :execute_without_newrelic_trace, execute_method
      alias_method execute_method, :execute_with_newrelic_trace
    end
  end
end
