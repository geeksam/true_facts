require "true_facts/version"
require "true_facts/exceptions"
require "true_facts/fact_checker"
require "true_facts/conversions"

class TrueFacts
  attr_reader :__parent__, :__dictionary__
  def initialize(parent = nil)
    @__parent__ = parent
    @__dictionary__ = Hash.new { |h,k| h[k] = self.class.new(self) }
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
    TrueFacts::Conversions.to_hash(self)
  end

  def __fact_ancestors__
    return [] unless __parent__.respond_to?(:__fact_ancestors__)
    [__parent__] + __parent__.__fact_ancestors__
  end

  private

  def store_fact(fact_name, new_value)
    old_value = __dictionary__.fetch(fact_name) { new_value } # works, but looks a bit weird
    FactChecker.check(self, fact_name, old_value, new_value)

    __dictionary__[fact_name] = new_value
  end

  def fetch_fact(fact_name)
    __dictionary__[fact_name]
  end
end
