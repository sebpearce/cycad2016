module Helpers
  class << self
    def symbolize_keys(hash)
      Hash[hash.map{ |k,v| [k.to_sym, v] }]
    end
  end
end
