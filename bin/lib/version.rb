module Virtuatable
  class Version

    attr_accessor :major

    attr_accessor :minor

    attr_accessor :patch

    def initialize(raw = '0.0.0')
      if raw.match(/\A\d+\.\d+\.\d+\z/)
        @major, @minor, @patch = raw.split('.').map(&:to_i)
      else
        @major, @minor, @patch = 0, 0, 0
      end
    end

    def to_s
      "#{major}.#{minor}.#{patch}"
    end

    def next(type: 'patch')
      copy = Virtuatable::Version.new(self.to_s)
      case type
      when 'major'
        copy.major += 1
        copy.minor = 0
        copy.patch = 0
      when 'minor'
        copy.minor += 1
        copy.patch = 0
      else
        copy.patch += 1
      end
      copy
    end
  end
end