#!ruby -Ku
# tokenを取得して保存するだけのツール
# 参考 : http://qiita.com/items/b147a8fb20b8ff3286b5
# 元 : https://github.com/jugyo/get-twitter-oauth-token/blob/master/bin/get-twitter-oauth-token

require "twitter"
require "yaml"

key = YAML.load IO.read "consumer_key.yml"
require "oauth"

consumer = OAuth::Consumer.new(
  key[:consumer_key], key[:consumer_secret],
  :site => "http://api.twitter.com/"
)

request = consumer.get_request_token
a_url = request.authorize_url

system('open', a_url) || puts("Access here:\n#{a_url}\n")

print "PIN >"
pin = gets.strip

token = request.get_access_token(
  :oauth_token => request.token,
  :oauth_verifier => pin
)

save = {
  :oauth_token => token.token,
  :oauth_token_secret => token.secret
}

IO.write "token.yml", YAML.dump(save)

p save


