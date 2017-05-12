class NoticeMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notice_mailer.sendmail_blog.subject
  #
  def sendmail_blog(blog)
    @blog = blog

    mail to: @blog.email,
         subject: '【test_achi】ブログが投稿されました'
  end

  def sendmail_contact(contact)
    @contact = contact

    mail to: @contact.email,
         subject: '【test_achi】問い合わせが投稿されました'
  end
end
