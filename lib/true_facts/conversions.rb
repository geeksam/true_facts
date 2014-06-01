class TrueFacts
  module Conversions
    extend self

    def to_hash(true_facts)
      pairs = true_facts.__dictionary__.map {|k, v|
        v = v.to_hash if v.respond_to?(:__fact_ancestors__)
        if v.respond_to?(:empty?) && v.empty?
          [] # don't hashify empty facts
        else
          [k, v]
        end
      }
      Hash[ pairs.compact ]
    end
  end
end
