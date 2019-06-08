# News-Feeds

各種サイネージ表示用 RSS/ATOM ニュース・フィードの URL 集です。（JSON 形式）

- ダウンロード: https://qithub-bot.github.io/News-Feeds/list_url_feeds_nice.json
- リポジトリ: https://github.com/Qithub-BOT/News-Feeds @ GitHub

## 利用対象ユーザー

- Qiita/Qiitadon ユーザー

## 追加できるフィード

- フィードのジャンル
  - 特にジャンル／嗜好は定めていませんが、**対象ユーザーが欲しいと思う情報のフィード**です。
  - 「禁止フィードではないが、マニアックすぎて極一部の人にしかニーズがない」と思うフィードは `list_url_feeds_niche.json` に追加してください。
- 禁止フィード
  - 通販サイト、政治的・宗教的な主義・主張を主体としたサイト。
- フィードの削除
  - 不快に思ったフィードは、削除して PR を遠慮なくあげてください。
- 登録したフィードが削除されたら
  - まずは、不快に思ったユーザーがいたということを認識し、`list_url_feeds_niche.json` に追加して再度 PR してください。
- フィードの書式： Atom/RSS 形式の XML ファイル（RSS 0.90〜2.0, Atom 0.3, 1.0）の URL
  - `gofeed-cli` コマンドで解析できるフィードの URL であれば問いません。
  - 逆に言えば **`gofeed-cli` コマンドで解析できるフィードのみ登録可**とします。

## フィードの追加方法

フィードを追加したい場合は、URL が登録可能か確認後、このリポジトリをローカルに `clone` し、追加した変更（フィード URL の追記）を PR してください。

### 登録可能なフィード URL か確認する

登録したいフィードの URL を下記 Docker コマンドで確認してください。フィードの内容が JSON 形式で表示されれば登録可能です。

```shellsession
$ # Yahoo!ニュースのフィードの例
$ docker run --rm keinos/gofeed-cli url https://news.yahoo.co.jp/pickup/rss.xml
...(JSON形式で表示)...
```

### フィード URL の追記

追加したいサイトの名前とフィードの URL を以下の要素で `list_url_feeds.json` に追記してください。

```json
    {
      "title": "[フィードのサイト名]",
      "url": "[フィードのURL]"
    }
```

この時、URL を基準に ABC 順に並ぶように追記してください。登録順のバイアスがかからないように、各要素の並び順は URL の ABC 順に並べる仕様にしています。

## PR 前の確認

PR 時に自動的にテストが実行されます。少なくとも、このテストをパスしないと PR はマージされません。

`docker` および `docker-compose` がインストールされている場合は、ローカルで事前に確認ができます。

```shellsession
$ ./run-test.sh
```

### 主なテスト内容

- JSON ファイルの構文チェック
- URL の重複チェック
- URL 先のフィードのダウンロードと解析
