require 'rspec'
require_relative '../lib/true_facts'

describe TrueFacts do
  subject(:fact) { TrueFacts.new }

  it "can remember a new fact using dot notation" do
    fact.leggings_are_pants = false
    expect( fact.leggings_are_pants ).to be false
  end

  it "agrees silently if you tell it the same fact twice" do
    fact.leggings_are_pants = false
    fact.leggings_are_pants = false
    expect( fact.leggings_are_pants ).to be false
  end

  it "explodes if you give it inconsistent facts" do
    fact.leggings_are_pants = false
    expect { fact.leggings_are_pants = true }
      .to raise_error( TrueFacts::WellActuallyError )
  end

  # This behavior is highly questionable
  it "can remember a new fact with a nested dot on a new fact" do
    fact.whales.narwhals.have_horns = "true story"
    expect( fact.whales.narwhals.have_horns ).to eq( "true story" )
  end

  it "can generate a hash" do
    fact.bacon = "is delicious, but will kill you"
    expect( fact.to_hash ).to eq({
      bacon: "is delicious, but will kill you",
    })
  end

  it "can generate a hash recursively" do
    fact.bunnies.just_cute_like_everybody_supposes = false
    fact.bunnies.got_them_hoppy_legs_and_twitchy_little_noses = true
    fact.bunnies.bunnies.it_must.be = "bunnies"
    expect( fact.to_hash ).to eq({
      bunnies: {
        just_cute_like_everybody_supposes: false,
        got_them_hoppy_legs_and_twitchy_little_noses: true,
        bunnies: {
          it_must: {
            be: "bunnies",
          }
        }
      }
    })
  end

  # doubling down on highly questionable behavior
  it "skips empty subfacts when converting to a hash" do
    fact.gotta_pee = "always"
    fact.hundreds.of.channels.and.nothing.to.watch # => deeply nested sub-fact
    expect( fact.to_hash ).to eq({
      gotta_pee: "always",
    })
  end

  specify "facts can't contain themselves directly" do
    expect { fact.is = fact }
      .to raise_error( TrueFacts::CircularLogicError )
  end

  specify "facts can't contain themselves indirectly", wip: true do
    expect { fact.Buffalo.buffalo.Buffalo.buffalo.buffalo.buffalo.Buffalo.buffalo = fact }
     .to raise_error( TrueFacts::CircularLogicError )
  end
end

