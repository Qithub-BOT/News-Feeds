[![CircleCI](https://circleci.com/gh/Qithub-BOT/News-Feeds/tree/master.svg?style=svg)](https://circleci.com/gh/Qithub-BOT/News-Feeds/tree/master)
[![](http://img.shields.io/badge/policy-Qithub%203原則-blue.svg)](https://github.com/Qithub-BOT/Qithub-ORG/wiki/%E3%83%9D%E3%83%AA%E3%82%B7%E3%83%BC%E3%80%81%E3%82%B3%E3%83%B3%E3%82%BB%E3%83%97%E3%83%88 "参加ポリシー")
![License](https://img.shields.io/badge/license-CC%20BY--SA%204.0-brightgreen.svg)
![日本語ドキュメント](https://img.shields.io/badge/document-ja-brightgreen.svg)
![Commit message in English](https://img.shields.io/badge/Commit%20message-en-brightgreen.svg)
![Source comment in English](https://img.shields.io/badge/code%20comment-en-brightgreen.svg)

# News-Feeds

**[Qiita](https://qiita.com/)/[Qiitadon](https://qiitadon.com/) ユーザー向けのニュース・フィード集**（JSON 形式の RSS/ATOM の URL 集）です。

- [list_url_feeds_nice.json](https://github.com/Qithub-BOT/News-Feeds/blob/master/list_url_feeds_nice.json)
- [list_url_feeds_niche.json](https://github.com/Qithub-BOT/News-Feeds/blob/master/list_url_feeds_niche.json)

フィード一覧は上記の２つ用意しています。各種サイネージ表示や自家製アプリなど、各自の責任でご自由にご利用ください。

- `list_url_feeds_nice.json`
  - 一般的なフィードの URL 一覧です。（JSON 形式）
  - ソース: https://github.com/Qithub-BOT/News-Feeds/blob/master/list_url_feeds_nice.json @ [GitHub](https://github.com/Qithub-BOT/News-Feeds)
  - ダウンロード: https://qithub-bot.github.io/News-Feeds/list_url_feeds_nice.json
- `list_url_feeds_niche.json`
  - ニッチなフィードの URL 一覧です。（JSON 形式）
  - ソース: https://github.com/Qithub-BOT/News-Feeds/blob/master/list_url_feeds_niche.json @ [GitHub](https://github.com/Qithub-BOT/News-Feeds)
  - ダウンロード: https://qithub-bot.github.io/News-Feeds/list_url_feeds_niche.json

## フィードの追加方法

**Qiita/Qiitadon ユーザーであれば自由に追加可能**です。PR（Pull Request）が CI テストをパスすると、自動的にマージされます。

1. URL が登録可能か確認
2. リポジトリの `clone`
3. フィード URL の追記（必要ならローカル・テストを実行）
4. 変更を PR

### 追加できるフィードの種類

- フィードのジャンル
  - 特にジャンル／嗜好は定めていませんが、**Qiita/Qiitadon のユーザーが欲しいと思う情報のフィード**であれば自由です。（禁止フィード除く）
  - 「禁止フィードではないが、マニアックすぎて極一部の人にしかニーズがない」と思うフィードは `list_url_feeds_niche.json` に追加してください。
- フィードの書式
  - [`gofeed-cli` コマンド](https://github.com/KEINOS/gofeed-cli)で解析できるフィードの URL であればフィード形式は問いませんが、以下のフィード・バージョンに対応しています。
    - Atom 0.3, 1.0
    - RSS 0.90 〜 2.0
    - `gofeed-cli` コマンドの説明と使い方は、下記「登録可能なフィード URL か確認する」を参照ください。

### PR（Pull Request）とマージ

- PR するブランチ
  - `master` ブランチで OK です。
- マージ
  - PR されると要件のテストが行われ、パスすると自動的にマージされます。事前に要件を網羅しているか確認する方法は、下記「PR 前の確認（ローカル・テスト）」を参照ください。

### 登録可能なフィード URL か確認する

このフィード一覧に追加できる URL は **`gofeed-cli` コマンドで解析できるフィード URL のみ登録可能**としています。

`gofeed-cli` コマンドは、Go 言語で書かれた RSS/Atom フィードを解析し、JSON 形式に変換するコマンドです。以下の書式で URL 先のフィードを取得・解析します。

```bash
gofeed-cli url [フィードのURL]
```

しかし、このコマンドは自身でコンパイルが必要なため、Docker で `keinos/gofeed-cli` を使う方法を推奨しています。

例えば、"Yahoo!ニュース" のフィードの場合は、以下の Docker コマンドで確認できます。フィードの内容が JSON 形式で表示されれば、そのフィードは登録可能です。

```shellsession
$ # Yahoo!ニュースのフィードの例
$ docker run --rm keinos/gofeed-cli url https://news.yahoo.co.jp/pickup/rss.xml
...(JSON形式で表示)...
```

### フィード URL の追記の仕方

追加したいサイトの名前とフィードの URL を、テキスト・エディタなどで `list_url_feeds.json` に追記してください。要素の書式は以下の通りです。

```json
    {
      "title": "[フィードのサイト名]",
      "url": "[フィードのURL]"
    }
```

- <font color=red>**注意**: 追加する際、URL で ABC 順に並べて（ソートした状態で）追記してください。</font><br>これは、登録順のバイアスがかからないように**各要素の並び順は URL の ABC 順に並べる仕様**にしています。要素の挿入箇所を探すのが面倒な場合は、一旦最下部に追記し、下記コマンドでソート＆上書きをすると便利です。（要 `jq` コマンド）

    ```bash
    file=list_url_feeds_nice.json && (rm -f $file && cat | jq '. | sort_by(.url)' > $file) < $file
    ```

### PR 前の確認（ローカル・テスト）

PR 時に自動的にテストが実行されます。少なくとも、このテストをパスしないと PR はマージされません。

PR 前にローカルでテストしたい場合は、以下のコマンドでテスト可能です。（要 `docker` および `docker-compose`）

```shellsession
$ ./run-test.sh
```

- 主なテスト内容
  - JSON ファイルの構文チェック
  - URL の重複登録チェック
  - 各フィードの要素の並び順（URL の ABC 順）
  - URL 先のフィードのダウンロードと解析

## 禁則事項

- 不正な登録をパスさせるような各種コードの改変は禁止です。

## フィードの削除について

登録が自由であるのと同じように**他のユーザーの判断でフィードも削除さる可能性があります**。

- 禁止フィード
  - 技術的・仕様的な情報の少ない通販系サイト、政治的・宗教的な主義・主張を主体としたサイト。
- フィードの削除
  - 不快に思ったフィードや情報の信憑性が低いと感じたフィードの登録は（個人的な感想であっても）遠慮なく削除して PR をあげてください。なお PR の際に削除理由を明記してください。
    - 例：「不快な記事の多いフィードなので削除」「検証不足の記事が多いフィードなので削除」「情報の質の悪いアフィ・サイトなので削除」など
- 登録したフィードが削除されたら
  - まずは、そのフィードに不快感を持ったユーザーがいたということを認識し、「やはり自分には必要な情報」と感じたらニッチ・バージョンの方（`list_url_feeds_niche.json`）に追加して再度 PR してください。
- デッド・フィードの削除
  - 登録後に「フィードが存在しなくなった」「`gofeed-cli` で解析できなくなった」などの変更があったら適宜削除して PR をお願いします。
