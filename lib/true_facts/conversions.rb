class TrueFacts
  module Conversions
    extend self

    def to_hash(true_facts)
      pairs = true_facts.__dictionary__.map {|k, v|
        v = v.to_hash if v.respond_to?(:__fact_ancestors__)
        [k, v]
      }
      Hash[ pairs ]
    end
  end
end
