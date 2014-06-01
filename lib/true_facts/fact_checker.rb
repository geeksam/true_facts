class TrueFacts
  module FactChecker
    extend self

    def check(true_facts, fact_name, old_value, new_value)
      check_for_retcon true_facts, fact_name, old_value, new_value
      check_for_factception true_facts, new_value
    end

    private

    def check_for_retcon(true_facts, fact_name, old_value, new_value)
      if new_value != old_value
        fail WellActuallyError.new( fact_name, old_value, new_value )
      end
    end

    def check_for_factception(true_facts, new_value)
      if new_value == true_facts || true_facts.__fact_ancestors__.include?(new_value)
        fail CircularLogicError, "Can't store facts inside themselves!"
      end
    end
  end
end
