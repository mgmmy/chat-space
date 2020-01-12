class GroupWorker
  include Sidekiq::Worker
  sidekiq_options queue: :group

  def perform(message, user_id)
    user = User.find(user_id)
    puts "#{user.name}さんがメッセージを送信しました：#{message}"
  end
end
