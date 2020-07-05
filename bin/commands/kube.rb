module Commands
  class Kube < Thor

    desc 'display <service>', 'Displays the kubernetes config for this service'
    method_option :port, default: '8080'
    method_option :replicas, default: '3'
    def display(service)
      puts factory.config(service, options)
    end

    desc 'current <service>', 'Display the kubernetes currently deployed version'
    def current(service)
      puts versions.kube(service)
    end

    desc 'create <service>', 'Creates the deployment, service, and ingress for a micro-service'
    method_option :retry, :type => :numeric, default: 0
    method_option :port, default: '8080'
    method_option :replicas, default: '3'
    def create(service)
      options[:retry].times do
        if versions.kube(service) == versions.latest(service)
          puts 'Similar images, waiting five more seconds...'
          sleep(5)
        end
      end
      factory.exec('apply', service, options)
    end

    desc 'delete <service>', 'Deletes the deployment, service and ingress for a micro-service'
    method_option :port, default: '8080'
    method_option :replicas, default: '3'
    def delete(service)
      factory.exec('delete', service, options)
    end

    private

    def factory
      Factories::Kubernetes.instance
    end

    def versions
      Factories::Versions.instance
    end
  end
end