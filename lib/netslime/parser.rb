require 'rubygems'
require 'mechanize'
require 'hpricot'

module NetSlime

  class Parser

    def exist? (data, pattern)
      data.include? pattern
    end

    def analyze (data, pattern = 'a')
      result = []
      doc = Hpricot(data)
      case pattern
      when 'a'
        (doc/pattern).each do |link|
  #        result << "#{link.inner_html} -> #{link[:href]}"
            result << "#{link[:href]}"
        end
      when 'img'
        (doc/pattern).each do|img|
          result << img.attributes['src']
        end
      else
        (doc/pattern).each do |text|
          result << text.inspect
        end
      end
      return result
    end
  end
end