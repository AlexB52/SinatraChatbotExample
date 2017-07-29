include Facebook::Messenger

Facebook::Messenger::Subscriptions.subscribe(access_token: ENV["ACCESS_TOKEN"])

Bot.on :message do |message|
  begin
    if message.text
      message.typing_on
      message.reply(text: 'hello I am the Country Bot')
    end
  rescue => e
    puts "============"
    puts e
    puts "============"
    message.reply(text: "Sorry there was an error")
  end
end
