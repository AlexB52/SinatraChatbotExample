include Facebook::Messenger

Facebook::Messenger::Subscriptions.subscribe(access_token: ENV['ACCESS_TOKEN'])

client = RecastAI::Client.new(ENV['RECAST_TOKEN'])
request = client.request

Bot.on :message do |message|
  begin
    if message.text
      message.typing_on
      response = request.analyse_text(message.text)

      intent = response.intent
      location = response.get('location')
      puts "location: #{location.inspect}"

      # message.reply(text: 'hello I am the Country Bot')
      message.reply(text: "Your intent is #{intent.slug}") if intent
      message.reply(text: "The location is #{location.formatted}") if location
    end
  rescue => e
    puts "============"
    puts e
    puts "============"
    message.reply(text: "Sorry there was an error")
  end
end
