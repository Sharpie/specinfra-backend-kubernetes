# frozen_string_literal: true

require 'specinfra/backend/exec'

# NOTE: Based on specinfra/backend/dockercli

module Specinfra
  module Backend
    class Kubectl < Exec
      def build_command(cmd)
        kubectl_cmd = %w[kubectl exec]
        kubectl_cmd << '--interactive' if get_config(:interactive_shell)
        kubectl_cmd << '--tty' if get_config(:request_pty)
        kubectl_cmd += kubectl_args
        kubectl_cmd << '--'
        kubectl_cmd << super(cmd)

        kubectl_cmd.join(' ')
      end

      def send_file(from, to)
        raise NotImplementedError, 'Sending files via kubectl is not implemented yet.'
      end

      def send_directory(from, to)
        raise NotImplementedError, 'Sending files via kubectl is not implemented yet.'
      end

      private

      def kubectl_args
        raise 'Set k8s_resource to namespace/kind/name/[container]' unless (resource = get_config(:k8s_resource))

        # TODO: Resolve deployment, statefulset, etc. to a pod reference as that is what kubectl cp will require.
        # TODO: Use kubectl wait to ensure the resolved pod is in a running state.

        resource = resource.split('/')

        args = ['-n', resource[0],
                '%s/%s' % resource[1..2]]
        args += ['-c', resource[3]] if (resource.length == 4)

        args
      end
    end
  end
end
