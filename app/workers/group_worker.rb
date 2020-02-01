class GroupWorker
  include Sidekiq::Worker
  sidekiq_options queue: :group

  def perform(id)
    group = Group.find(id)
    NotificationMailer.send_confirm_to_member(group).deliver_later
  end
end
