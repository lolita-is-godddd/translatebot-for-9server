#! ruby -Ku
require 'discordrb'
require 'yaml'
require 'net/http'
require 'cgi'
require 'kconv'
Config = YAML.load_file('config.yml')
bot = Discordrb::Commands::CommandBot.new token: Config['token'], client_id: Config['Client_id'], prefix: Config['prefix']

bot.ready do
  bot.game='type '+Config['prefix']+'help'
end

bot.command :random do |event, min, max|
  rand(min.to_i .. max.to_i)
end

bot.command(:staition,min_args: 1,max_args: 1 ) do |event, name|
  @base = 'http://seesaawiki.jp/maru9-railway-list/d/'
  #SeesaawikiはEUC-JP
  if name.include?('駅') == false then
     name << '駅'
  end
  event << @base + CGI.escape(name.toeuc)
end

def logs user,message
  puts @user + 'が' + @message + 'されました'
end

bot.message(with_text: 'hello') do |event|
  event.respond 'hello world!'
end

bot.run
