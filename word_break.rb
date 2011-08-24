#/usr/bin/env ruby
require 'set'
require 'rspec'
require 'enumerating'

module Enumerable
  alias mapping collecting # enumerating defines collecting.. but I prefer mapping...
end

# Given an input string and a dictionary of words,
# segment the input string into a space-separated
# sequence of dictionary words if possible. For
# example, if the input string is "applepie" and
# dictionary contains a standard set of English words,
# then we would return the string "apple pie" as output.

module WordBreak
  class << self
    def segmentize(string, dictionary)
      segmentize = memoize( -> string {
        return string if dictionary.include?(string)

        prefixes = (0...(string.size)).mapping { |i| [string[0..i], i]}

        candidates = prefixes.selecting { |(prefix,i)| dictionary.include?(prefix) }

        solutions = candidates.mapping { |(prefix,i)|
            remaining_segment = segmentize(string[(i+1)..-1], dictionary)
            [prefix, remaining_segment].join(" ") if remaining_segment }.
          rejecting {|r| r.nil? }

        solutions.first })

      segmentize.call(string)
    end

    private

    def memoize(fn)
      cache = {}
      -> *args { cache.include?(args) ? cache[args] : cache[args] = fn.call(*args) }
    end

  end
end

describe WordBreak do
  describe ".segmentize" do
    it "returns a (the first) valid segmentaion of the string provided" do
      WordBreak.segmentize("applepie", %w[apple pie]).should == "apple pie"
    end

    it "returns nil when no valid segmentation exists" do
      WordBreak.segmentize("blah", %w[apple pie].to_set).should be_nil
      WordBreak.segmentize("aaaab", %w[a aa aaa aaaa].to_set).should be_nil
    end

    it "handles strings with 'false starts' (i.e. it backtracks)" do
      WordBreak.segmentize("anappleaday", %w[a an apple day].to_set).should == "an apple a day"
    end

  end
end
