#!ruby -Ku
# TLのjsonを集める部分

require "json"
require "yaml"

libdir = File.join File.dirname(__FILE__)
$:.unshift libdir
Dir::chdir libdir

require "tweets"



class TLArchiver
  SAVE_DIR = "twitter_timelime_json_archive"
  MAX_ID_SAVE = File.join(SAVE_DIR, "maxid.txt")
  
  def initialize
    # 保存先が無い場合に初期化
    Dir.mkdir(SAVE_DIR) unless File.directory?(SAVE_DIR)
    IO.write(MAX_ID_SAVE, "0") unless File.file?(MAX_ID_SAVE)
    
    # 前に読み込んだ最大のIDを読み込む
    @max_id = IO.read(MAX_ID_SAVE).to_i
  end
  
  def get_timeline
    @tweets = Tweets.get_while(:home_timeline) { |tw| tw[:id] > @max_id }
  end
  
  def save_tweets
    mn, mx = @tweets.minmax_id
    f = File.join(SAVE_DIR, "#{mn}-#{mx}.json")
    json = JSON.generate @tweets.collect{ |tw| tw.attrs }
    IO.write(f, json)
    IO.write(MAX_ID_SAVE, mx.to_s)
  end
end


def timeline_collect
  puts "login..."
	config_twitter
  
  puts "read config..."
  t = TLArchiver.new
  
  puts "get TL..."
  t.get_timeline
  
  puts "save..."
  t.save_tweets
  
  puts "complete"
end




timeline_collect if __FILE__ == $0


