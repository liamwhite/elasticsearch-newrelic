# frozen_string_literal: true
require 'new_relic/agent/method_tracer'

DependencyDetection.defer do
  @name = :elasticsearch

  depends_on do
    defined?(::Elasticsearch::Transport::Client) &&
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
        return perform_request_without_newrelic_trace(method, path, params, body) unless method == 'GET'

        result = nil
        callback = proc do |res, metric, elapsed|
          NewRelic::Agent::Datastores.notice_statement(body.inspect, elapsed)
          result = res
        end

        NewRelic::Agent::Datastores.wrap("Elasticsearch", "search", __tracepath(path), callback) do
          NewRelic::Agent.disable_all_tracing do
            perform_request_without_newrelic_trace(method, path, params, body)
          end
        end
        result
      end

      alias_method :perform_request_without_newrelic_trace, execute_method
      alias_method execute_method, :perform_request_with_newrelic_trace

      def __tracepath(path)
        v = path.split('/')[0]
        (v.nil? || v == '') ? path : v
      end
    end
  end
end
