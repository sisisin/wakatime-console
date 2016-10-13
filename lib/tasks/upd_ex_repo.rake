task :upd_ex_repo => :environment do
  FetchExcludeRepository.new.save
end
