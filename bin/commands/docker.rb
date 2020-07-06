module Commands
  class Docker < Thor

    desc 'latest <service>', 'Displays the last version of the Docker image for the service'
    def latest(service)
      puts Factories::Versions.instance.latest(service)
    end

    desc 'display <service>', 'Displays the content of the Dockerfile'
    method_option :port, default: '8080'
    method_option :bundler, default: '2.1.4'
    method_option :ruby, default: '2.6.5'
    def display(service)
      puts dockerfile(service, options).content
    end

    desc 'next <service>', 'Displays the next version of the service'
    method_option :verbose, type: :boolean, default: false
    def next(service)
      if options[:verbose]
        last_pr = Factories::Git.instance.last_pr(service)
        last_pr_labels = Factories::Git.instance.last_pr_labels(service)
        puts "Last pull request was #{last_pr[:title]}"
        puts "its tags were #{last_pr_labels}"
      end
      puts Factories::Versions.instance.next(service)
    end

    desc 'create <service>', 'Creates a new image and pushes it'
    method_option :port, default: '8080'
    method_option :bundler, default: '2.1.4'
    method_option :ruby, default: '2.6.5'
    method_option :local, default: false, type: :boolean
    def create(service)
      v = Factories::Versions.instance.next(service)
      if options[:local] == true
        system "docker build -t virtuatable/#{service}:#{v} ."
      else
        file = dockerfile(service, options).store
        system "docker build -t virtuatable/#{service}:#{v} -f #{file} ."
      end
      system "docker push virtuatable/#{service}:#{v}"
    end

    private

    # Gets the representation of the dockerfile, with the variables interpolated.
    # @return [Virtuatable::Files::Dockerfile] the reprensetation of the dockerfile.
    def dockerfile(service, options)
      Virtuatable::Files::Dockerfile.new(service, options)
    end
  end
end