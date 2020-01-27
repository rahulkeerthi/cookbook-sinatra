require 'nokogiri'
require 'open-uri'

class ServiceObject
  def initialize(keyword)
    @keyword = keyword
  end

  def call
    # 'https://www.bbcgoodfood.com/search/recipes?query=#{@keyword}'
    doc = Nokogiri::HTML(open("https://www.bbcgoodfood.com/search/recipes?query=#{@keyword}").read, nil, 'utf-8')
    results, descriptions, total_time, skill_level = Array.new(4) { [] }
    doc.css('.field-items div').each { |element| descriptions << element.content }
    doc.css('.teaser-item__info-item--total-time').each { |element| total_time << element.content }
    doc.css('.teaser-item__info-item--skill-level').each { |element| skill_level << element.content }
    doc.css('.teaser-item__title a').each_with_index do |title, index|
      results << Recipe.new(title.content, descriptions[index], total_time[index], skill_level[index])
    end
    results.first(5)
  end
end
