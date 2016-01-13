require 'erubis'
require 'pry'

FILES = %w(
  this_is_a_timmocs
  timmocs_are_not_people
  individuals
  adamant
  ved
  generations
  branch
  branch_want_keep
  branch_update_point
  no_new_timmoc
  only_no_changes
  most_recent_common_ancestor
  go_back_for_ancestor
  two_parents
  individual
  merging
  merge_with_ancestor
  ved_intervene
  need_ancestor
  triangle_horn
  do_not_rely_on_ved
  akward_she_head_thing
  changes_on_multi_branches
  do_not_know_conflict
  early_rebasing
  more_rebasing
  deleted_rebased_from_branch
  )

class Page

  def initialize(current)
    @current = current
    index = FILES.index(@current)
    @previous = FILES[index - 1] if index > 0
    @nxt = FILES[index + 1] if index < FILES.count - 1
    @text = File.read("text/#{@current}.txt").chomp
  end

  def html
    template = File.read('bin/template.erb')
    template = Erubis::Eruby.new(template)
    template.result(current: @current, previous: @previous, nxt: @nxt, text: @text)
  end

end

FILES.each.with_index do |file, index|
  html = Page.new(file).html
  File.open("html/#{file}.html", "w") { |io| io.puts html }
end
