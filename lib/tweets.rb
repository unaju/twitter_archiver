#!ruby -Ku
# twitterのTLを取得する部分

require "yaml"
#require "json"

require "twitter"
# 参考 : 
# http://route477.net/w/?RubyTwitterJa
# https://github.com/sferik/twitter

# SSL接続がうまくいかない場合のみ
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

# Twitterのconfig
def config_twitter
  cs = YAML.load IO.read "consumer_key.yml"
  tk = YAML.load IO.read "token.yml"
  cf = cs.merge tk
  Twitter.configure { |conf|
    cf.each{ |k,v| conf.__send__("#{k}=",v) }
  }
  # 動作確認
  #p "conf ok"
  #puts Twitter.home_timeline
end




# TweetのArray
class Tweets < Array
  # TLを取得
  def self.home_timeline option = {:include_entities => true}
    self.new Twitter.home_timeline(option)
  end
  
  # blockがfalseを返すまで取得し続ける.
  # blockにはtweetが新しい順番(IDの大きい方から)渡される.
  # methodには home_timeline とかを渡す.
  # optionに最初からmax_idを渡しておけばそのid以下を対象にできる.
  def self.get_while method, option = nil, &checker
    option ||= {:include_entities => true, :count => 200 } # countは200がmax
    res = self.new
    
    # 取得ループ
    catch(:return) {
      loop {
        throw :return if (ta = self.__send__(method,option)).empty?
        ta.each{ |tweet|
          throw :return unless checker.call(tweet)
          res << tweet
          option[:max_id] = tweet[:id] # 最大ID更新
        }
      }
    }
    return res
  end
  
  # IDで比較するLambdaとその使用例
  CompID = lambda {|a,b| a[:id] <=> b[:id]}
  def max_id; max(&CompID)[:id]; end
  def min_id; min(&CompID)[:id]; end
  
  def ids; collect{|t| t[:id]}; end
  def minmax_id; ids.minmax; end
  
end





