# frozen_string_literal: true

class MyMailer < Devise::Mailer
  def confirmation_instructions(record, token, opts = {})
    mail = super
    mail.subject = "Confirmation instructions for #{record.username}"
    mail
  end
end
