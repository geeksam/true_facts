require "true_facts/version"
require "true_facts/exceptions"
require "true_facts/fact_checker"

class TrueFacts
  attr_reader :parent
  def initialize(parent = nil)
    @parent = parent
    @dictionary = Hash.new { |h,k| h[k] = self.class.new(self) }
  end

  def method_missing(method, *args, &block)
    if method =~ /^(.*)=$/
      store_fact $1.to_sym, args.first
    else
      fetch_fact method.to_sym
    end
  end

  def respond_to_missing?(*)
    true
  end

  def to_hash
    pairs = dictionary.map {|k, v|
      v = v.to_hash if v.respond_to?(:__fact_ancestors__)
      [k, v]
    }
    Hash[ pairs ]
  end

  def __fact_ancestors__
    return [] unless parent.respond_to?(:__fact_ancestors__)
    [parent] + parent.__fact_ancestors__
  end

  private
  attr_reader :dictionary

  def store_fact(fact_name, new_value)
    old_value = dictionary.fetch(fact_name) { new_value }
    FactChecker.check(self, fact_name, old_value, new_value)

    dictionary[fact_name] = new_value
  end

  def fetch_fact(fact_name)
    dictionary[fact_name]
  end
end
