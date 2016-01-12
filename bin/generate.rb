require 'erubis'

FILES = ["adamant.svg", "akward_she_head_thing.svg", "branch.svg", "branch_update_point.svg", "branch_want_keep.svg", "changes_on_multi_branches.svg", "deleted_rebased_from_branch.svg", "do_not_know_conflict.svg", "do_not_rely_on_ved.svg", "early_rebasing.svg", "generations.svg", "go_back_for_ancestor.svg", "individual.svg", "individuals.svg", "merge_with_ancestor.svg", "merging.svg", "more_rebasing.svg", "most_recent_common_ancestor.svg", "need_ancestor.svg", "no_new_timmoc.svg", "only_no_changes.svg", "this_is_a_timmocs.svg", "timmocs_are_not_people.svg", "triangle_horn.svg", "two_parents.svg", "ved.svg", "ved_intervene.svg",]

class Page

  def initialize(previous, current, nxt)
    @previous = previous
    @current = current
    @nxt = nxt
  end
  def html
    template = File.read('bin/template.erb')
    template = Erubis::Eruby.new(template)
    template.result(current: @current)
  end

end

FILES.each.with_index do |file, index|
  html = Page.new(FILES[index - 1], file, FILES[index + 1]).html
  File.open('html/' + file.gsub('.svg', '.html'), "w") { |io| io.puts html }
end
