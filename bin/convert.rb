require 'pathname'
require 'nokogiri'
require 'pry'

Pathname.new('svg/').each_child do |ch|
  doc = Nokogiri::XML(File.open(ch.cleanpath))
  text_file = File.open("text/#{ch.basename.to_s.gsub('.svg', '.txt')}", 'w')
  text = doc.css('tspan').map(&:text).join(' ').gsub('  ', ' ')
  text_file.puts text
  File.open(ch.cleanpath, 'w') { |f|
    doc.css('text').each(&:remove)
    doc.css('rect').each(&:remove)
    doc.root.attribute('height').value = '500'
    doc.root.attribute('viewBox').value = "0 0 #{doc.root.attribute('width').value} 500"
    f.puts doc.to_xml
  }

end
