module Factories
  class Kubernetes
    include Singleton

    def config(service, options)
      options['service'] = service
      options['version'] = Factories::Versions.instance.latest(service)
      parsed = %w(deployment ingress service).map do |filename|
        Virtuatable::Files::Base.new("#{filename}.yml", options).content
      end
      parsed.join("\n---\n")
    end

    def exec(command, service, options)
      path = "/tmp/#{service}.yml"
      file = File.open(path, 'w') do |f|
        f.write(config(service, options))
      end
      system "cat /tmp/#{service}.yml | kubectl #{command} -f -"
      File.delete(path)
    end
  end
end