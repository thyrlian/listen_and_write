# encoding: UTF-8

require 'json'

module Dictation
  class Word
    attr_accessor :value, :translation
    
    def initialize(value, translation = nil)
      @value = value
      @translation = translation
    end
    
    def orthography
      decompose(@value)
    end
    
    def decompose(word)
      word.split(//).map! do |x|
        normalize(x)
      end
    end
    
    def normalize(letter)
      letter = letter.downcase.chomp
      case letter
      when 'ß'
        'ss'
      else
        letter
      end
    end
    
    def to_json(*args)
      {
        'json_class' => self.class.name,
        'data'       => [ @value, @translation ]
      }.to_json(*args)
    end
    
    class << self
      def json_create(object)
        new(*object['data'])
      end
    end
    
    private :decompose, :normalize
  end
end