namespace :expire_data_remove do
  desc 'expire data remove'
  task run: :environment do
    task_name = NihongoChushin::ExpireDataRemover.task_name
    task_executor = NihongoChushin::TaskExecutor.new(task_name: task_name)
    task_executor.run do
      num = NihongoChushin::ExpireDataRemover.run
      if num.zero?
        pp "削除対象のコメントはありませんでした。"
      else
        pp "#{num}件のコメントを削除しました。"
      end
    end
  end
end
