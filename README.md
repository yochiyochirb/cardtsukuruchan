# cardtsukuruchan

Doorkeeper の申込時アンケートで記入してもらった「やりたいこと」を GitHub Project に Card として登録するスクリプトです。

## 準備

- [Personal access tokens](https://github.com/settings/token://github.com/settings/tokens) のページで token を取得する必要があります。
- .env.sample ファイルを元にして、必要な情報を記入した .env ファイルを用意する必要があります。

```shell
cp .env.sample .env
```

## 使い方

Doorkeeper の各イベント管理ページからエクスポートした `yochiyochirb-tickets-#{event_id}.xlsx` をプロジェクトルートに置いて使います。

```shell
$ ruby extract.rb yochiyochirb-tickets-12345.xlsx
```

## 留意事項

アンケートの質問形式や設問順が変わらないことを前提にして作られているので、それらを変えると期待通りに動かなくなります:bomb:
