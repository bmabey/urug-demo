#/usr/bin/env ruby
require 'set'
require 'rspec'

# Given an input string and a dictionary of words,
# segment the input string into a space-separated
# sequence of dictionary words if possible. For
# example, if the input string is "applepie" and
# dictionary contains a standard set of English words,
# then we would return the string "apple pie" as output.

module WordBreak
  class << self
    def segmentize(string, dictionary)
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
