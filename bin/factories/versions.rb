module Factories
  class Versions
    include Singleton

    attr_reader :git

    def initialize
      @git = Factories::Git.instance
    end

    def latest(service)
      current(service).to_s
    end

    def next(service)
      current(service).increment!(increment service).to_s
    end

    def increment(service)
      ['major', 'minor'].each do |label|
        return label if git.last_pr_labels(service).include? label
      end
      'patch'
    end

    def kube(service)
      command = `kubectl get deployments/#{service}-deployment -o yaml`
      deployment = YAML.load(command)
      image = deployment['spec']['template']['spec']['containers'][0]['image']
      image.split(':').last
    end

    private

    def current(service)
      version = begin
        url = "https://registry.hub.docker.com/v2/repositories/virtuatable/#{service}/tags"
        body = JSON.parse(Faraday.get(url).body)
        body['results'][0]['name']
      rescue
        '0.0.0'
      end
      Semantic::Version.new(version)
    end
  end
end