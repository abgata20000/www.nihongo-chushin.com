namespace :expire_data_remove do
  desc 'expire data remove'
  task run: :environment do
    NihongoChushin::ExpireDataRemover.run
  end
end
