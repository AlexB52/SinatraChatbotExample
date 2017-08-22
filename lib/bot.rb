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
      puts "intent: #{intent.inspect}"
      puts "location: #{location.inspect}"

      if intent.slug == 'know-population' && location
        country = location.formatted
        data = Restcountry::Country.find_by_name(country)
        population = data.population.to_s.reverse.gsub(/...(?=.)/,'\&,').reverse

        message.reply(text: "#{country} has #{population} habitants")
        # message.reply(text: "The capital of #{country} is #{data.capital}")
      else
        message.reply(text: "Sorry I did not quite get that")
      end
    else
      message.reply(text: "I only respond to text")
    end
  rescue => e
    puts "============"
    puts e
    puts "============"
    message.reply(text: "#{e}")
  end
end
