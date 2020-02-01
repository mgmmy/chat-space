class NotificationMailer < ActionMailer::Base
    default from: "mail_test@example.com"

    def send_confirm_to_member(group)
        @group = group
        @email_list = []
        @link = "http://localhost:3001/groups/#{@group.id}/messages"
        group.users.each do |user|
            user_email = user.email
            @email_list << user_email
        end
        mail(
            subject: "【chat-space】新しいメッセージがあります",
            to: @email_list
        ) do |format|
            format.text
        end
    end
end
