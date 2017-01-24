#! ruby -Ku
require 'discordrb'
require 'yaml'
Config = YAML.load_file('config.yml')
bot = Discordrb::Commands::CommandBot.new token: Config['token'], client_id: Config['Client_id'], prefix: Config['prefix']

bot.ready do
  bot.game='type '+Config['prefix']+'help'
end

bot.command(:hello)  do |event|
  event << 'hello world'
end

bot.command :random do |event, min, max|
  rand(min.to_i .. max.to_i)
end

def logs user,message
  puts @user + 'が' + @message + 'されました'
end

bot.message(with_text: "Ping!") do |event|
  event.respond "Pong!"
end

bot.run
