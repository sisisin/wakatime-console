task :daily => :environment do
  SummaryAggregator.new.save_all
end
