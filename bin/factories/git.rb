module Factories
  class Git
    include Singleton

    attr_reader :client, :local

    def initialize
      logger = Logger.new(STDOUT)
      logger.level = Logger::ERROR
      @local = ::Git.open('.', log: logger)
      @client = Octokit::Client.new(access_token: ENV['GITHUB_TOKEN'])
    end

    # Gets the pull request that was merged the last on master, so that
    # you can later get its labels and check what the increment for the
    # next version should be (major, minor, patch)
    #
    # @return [NilClass, Hash] the hash representation of the pull request.
    def last_pr(service)
      requests = client.pull_requests("virtuatable/#{service}", {state: 'all'})
      requests.find { |r| r[:merge_commit_sha] == last_commit }
    end

    def last_pr_labels(service)
      return [] if last_pr(service).nil?
      return last_pr(service)[:labels].map { |l| l[:name] }
    end

    def last_commit
      local.log(1).first.sha
    end
  end
end