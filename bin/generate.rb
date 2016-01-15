require 'erubis'
require 'pry'

FILES = %w(
  this_is_a_timmocs
  timmocs_are_not_people
  adamant
  ved
  generations
  branch_pointers
  branch_pointers_head
  what_is_branch
  branch_moved_forward
  branch
  branch_update_point
  merging
  two_parents
  individual
  conflict_question
  ved_intervene
  rebase
  rebase_diffs
  more_rebase
  rebased
  thats_all
  )


class Page

  TEMPLATE = Erubis::Eruby.new(File.read('bin/template.erb'))

  attr_accessor :group_index, :index, :image, :text, :previous, :nxt

  def initialize(group_index, index, name, text)
    @group_index = group_index
    @index = index
    @name = name
    @text = text
  end

  def html_filename
    "#{(group_index + 1).to_s.rjust(3, "0")}_#{index + 1}_#{@name}.html"
  end

  def output_html
    File.open("output/#{html_filename}", "w") do |io|
      io.puts TEMPLATE.result(name: @name, text: @text, previous: @previous, nxt: @nxt)
    end
  end

  def copy_svg
    `cp svg/#{@name}.svg output/svg/#{@name}.svg`
  end

end

['output', 'output/svg'].each do |dir|
  Dir.mkdir(dir) unless Dir.exists?(dir)
end

text_groups = []
FILES.each.with_index do |file, index|
  file_texts = File.read("text/#{file}.txt").split(/\n+/)
  text_groups << {name: file, texts: file_texts}
end

pages = []
text_groups.each.with_index do |text_group, group_index|
  text_group[:texts].each.with_index do |text, text_index|
    pages << Page.new(group_index, text_index, text_group[:name], text)
  end
end

pages.each.with_index do |page, index|
  page.previous = index <= 0 ? nil : pages[index - 1].html_filename
  page.nxt = index >= pages.count - 1 ? nil : pages[index + 1].html_filename
end

pages.each do |page|
  page.output_html
  page.copy_svg
end

