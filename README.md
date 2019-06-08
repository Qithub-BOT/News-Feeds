[![CircleCI](https://circleci.com/gh/Qithub-BOT/News-Feeds/tree/master.svg?style=svg)](https://circleci.com/gh/Qithub-BOT/News-Feeds/tree/master)
![Mergify IO](https://img.shields.io/endpoint.svg?url=https://gh.mergify.io/badges/Qithub-BOT/News-Feeds&style=flat)
[![](http://img.shields.io/badge/policy-Qithub%203原則-blue.svg)](https://github.com/Qithub-BOT/Qithub-ORG/wiki/%E3%83%9D%E3%83%AA%E3%82%B7%E3%83%BC%E3%80%81%E3%82%B3%E3%83%B3%E3%82%BB%E3%83%97%E3%83%88 "参加ポリシー")
![License](https://img.shields.io/badge/license-CC%20BY--SA%204.0-brightgreen.svg)
![日本語ドキュメント](https://img.shields.io/badge/document-ja-brightgreen.svg)
![Commit message in English](https://img.shields.io/badge/Commit%20message-en-brightgreen.svg)
![Source comment in English](https://img.shields.io/badge/code%20comment-en-brightgreen.svg)

# News-Feeds

[Qiita](https://qiita.com/)/[Qiitadon](https://qiitadon.com/) ユーザー向けのニュース・フィード集（RSS/ATOM の URL 集）です。（JSON 形式）

- リポジトリ: https://github.com/Qithub-BOT/News-Feeds @ GitHub

## 利用対象ユーザー

- [Qiita](https://qiita.com/)/[Qiitadon](https://qiitadon.com/) ユーザー

## 利用目的

- 上記の**対象ユーザーが日常的に情報を得るためのニュース・フィード集**です。各種サイネージ表示用など、各自の責任でご自由にご利用ください。

## フィード URL の一覧ファイル

以下のファイルをご利用ください。

- `list_url_feeds_nice.json` : 一般的なフィードの URL 一覧です。（JSON 形式）
  - ダウンロード: https://qithub-bot.github.io/News-Feeds/list_url_feeds_nice.json
- `list_url_feeds_niche.json`: ニッチなフィードの URL 一覧です。（JSON 形式）
  - ダウンロード: https://qithub-bot.github.io/News-Feeds/list_url_feeds_niche.json

## フィードの追加方法

上記の一覧ファイルにフィードを追加したい場合、**対象ユーザーであれば自由に追加可能**です。

URL が登録可能か確認後、このリポジトリをローカルに `clone` し、追加した変更（フィード URL の追記）を PR してください。

## 追加できるフィードの種類

- フィードのジャンル
  - 特にジャンル／嗜好は定めていませんが、**対象ユーザーが欲しいと思う情報のフィード**です。（禁止フィード除く）
  - 「禁止フィードではないが、マニアックすぎて極一部の人にしかニーズがない」と思うフィードは `list_url_feeds_niche.json` に追加してください。
- フィードの書式
  - Atom/RSS 形式の XML ファイル（RSS 0.90〜2.0, Atom 0.3, 1.0）の URL
    - `gofeed-cli` コマンドで解析できるフィードの URL であればフィード形式は問いません。
    - 逆に言えば **`gofeed-cli` コマンドで解析できるフィードのみ登録可**とします。（確認方法は「登録可能なフィード URL か確認する」を参照）
- PR するブランチ
  - `master` ブランチで OK。

## フィードの削除

登録と同じように**対象ユーザーの判断でフィードも削除されます**。

- 禁止フィード
  - 技術的・仕様的な情報の少ない通販系サイト、政治的・宗教的な主義・主張を主体としたサイト。
- フィードの削除
  - 不快に思ったフィードや情報の信憑性が低いと感じたフィードの登録は（個人的な感想であっても）遠慮なく削除して PR をあげてください。なお PR の際に削除理由を明記してください。
    - 例：「不快な記事の多いフィードなので削除」「検証不足の記事が多いフィードなので削除」「情報の質の悪いアフィ・サイトなので削除」など
- 登録したフィードが削除されたら
  - まずは、そのフィードに不快感を持ったユーザーがいたということを認識し、「やはり自分には必要な情報」と感じたらニッチ・バージョンの方（`list_url_feeds_niche.json`）に追加して再度 PR してください。
- デッド・フィードの削除
  - 登録後にフィードが存在しない、`gofeed-cli` で解析できないなどの変更があったら適宜削除して PR をお願いします。

## 登録可能なフィード URL か確認する

登録したいフィードの URL を下記 Docker コマンドで確認してください。フィードの内容が JSON 形式で表示されれば登録可能です。（要 Docker）

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

- <font color=red>**注意**</font>: 追加する際、URL を基準に ABC 順に並ぶように追記してください。登録順のバイアスがかからないように、**各要素の並び順は URL の ABC 順に並べる仕様**にしています。

## PR 前の確認

PR 時に自動的にテストが実行されます。少なくとも、このテストをパスしないと PR はマージされません。

`docker` および `docker-compose` がインストールされている場合は、ローカルで事前に確認ができます。

```shellsession
$ ./run-test.sh
```

### 主なテスト内容

- JSON ファイルの構文チェック
- URL の重複登録チェック
- 各フィードの要素の並び順（URL の ABC 順）
- URL 先のフィードのダウンロードと解析

### 禁則事項

- 不正な登録をパスさせるような各種コードの改変は禁止です。
