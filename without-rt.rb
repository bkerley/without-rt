require 'rubygems'
require 'sinatra'
require 'twitter'

t = Twitter::Base.new('without_rt', 'stop_all_retweets')

get '/' do
  "set your twitter client to point at this address instead of real twitter"
end

get '/statuses/friends_timeline.:format' do
  all_statuses = t.timeline
  filtered_statuses = all_statuses.reject{ |s| looks_like_rt s }
  filtered_statuses.map{|s| "#{s.user.name}: #{s.text}"}.join("<br \>")
end

def looks_like_rt(status)
  return true if status.text =~ /^RT\s/
  return true if status.text[0..40] =~ /re-?tweet/
end
