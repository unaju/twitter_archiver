#!ruby -Ku
libdir = File.join File.dirname(__FILE__), '..', 'lib'
$:.unshift libdir
Dir::chdir libdir

require 'test/unit'
require 'tweets'

class TweetsTest_Tester < Test::Unit::TestCase
  def setup
    config_twitter
  end
  
  def view_tweets ta
    puts ta.collect{ |tw| tw.inspect }.join("\n")
  end
  
  def test_get_timeline
    # 40件取得し表示
    n = 0;
    t = Tweets.get_while(:home_timeline) { |t| n += 1; n < 40 }
    view_tweets t
  end
end
