require 'ruby-prof'
class CategoryWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker # Important!


  def perform
    RubyProf.start
    cats=Category.where("pages_count >'100'").order(pages_count: :desc).limit(100).pluck(:id)
    cats.each do |cat|

      Category.reset_counters(cat, :pages)
    end

    feeds=Feed.limit(500).pluck(:id)
    feeds.each do |feed|
      Feed.reset_counters(feed, :pages)
    end
    result = RubyProf.stop
    # print a flat profile to text
    printer = RubyProf::FlatPrinter.new(result)
    printer.print(STDOUT)
  end
end