require 'puppet/confine'

class Puppet::Confine::Block < Puppet::Confine
  def self.summarize(confines)
    confines.inject(0) { |count, confine| count + confine.summary }
  end

  def values
    # Call and cache the results of each block
    @values.map! do |value|
      next value unless value.respond_to? :call
      value.call
    end
  end

  def pass?(value)
    !!value
  end

  def message(value)
    "block returned #{value}"
  end

  def summary
    result.find_all { |v| v }.length
  end
end
