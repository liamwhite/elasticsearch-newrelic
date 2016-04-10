require 'new_relic/agent/method_tracer'

DependencyDetection.defer do
  @name = :elasticsearch

  depends_on do
    defined?(::Elasticsearch::Model) &&
    !NewRelic::Control.instance['disable_elasticsearch'] &&
    ENV['NEWRELIC_ENABLE'].to_s !~ /false|off|no/i
  end

  executes do
    NewRelic::Agent.logger.info 'Installing Elasticsearch Instrumentation'
  end

  executes do
    require 'new_relic/agent/datastores'

    ::Elasticsearch::Transport::Client.class_eval do
      # Method to hijack
      execute_method = :perform_request

      def perform_request_with_newrelic_trace(method, path, params={}, body=nil)
        result = nil
        callback = proc do |res, metric, elapsed|
          NewRelic::Agent::Datastores.notice_statement(body.inspect, elapsed)
          result = res
        end

        NewRelic::Agent::Datastores.wrap("Elasticsearch", "search", path, callback) do
          perform_request_without_newrelic_trace(method, path, params, body)
        end
        result
      end

      alias_method :perform_request_without_newrelic_trace, execute_method
      alias_method execute_method, :perform_request_with_newrelic_trace
    end
  end
end
