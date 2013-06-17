# twitter json archiver

----
## 機能

twitterのTLで見えるだけの量をjsonで保存していきます.
ただし一回で見える分(2000tweetsくらい？)のTLしか保存できません.
また,APIの制限があるため保存できるTLの数にも限りがあります.
このため流速が速い場合は取得漏れが発生します.

----
## 保存形式
保存先はスクリプトのあるディレクトリに対して'/twitter_timelime_json_archive', 
保存ファイル名は'<最小TweetID>-<最大TweetID>.json'
の形式で,中身はTweetのattributeを格納したHashの配列のjsonです.


----
## 使い方
* 1. gemを入れる

`gem install bundle`した後,`twitter_archive/Gemfile`があるディレクトリに移動し,
`bundle install`して下さい. オプションはお好みで.

* 2. コンシューマーキーを設定

コンシューマーキーを取得し,

    ---
    :consumer_key: AAAAAAAAAAAAAAAAAAAAA
    :consumer_secret: AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA

の形式で`consumer_key.yml`ファイルに保存して下さい.

* 3. トークンの取得

`ruby token_getter.rb`でtokenを取得します.上手く行けば`token.yml`というファイルに

    ---
    :token: 000000000-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
    :secret: AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA

という形式で保存されています.



----





