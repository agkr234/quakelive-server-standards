# makinero lan用 QLサーバー

## QLサーバーの立て方 (Windows 10 - Docker Desktop)
1. docker用のファイルをダウンロードをする。
    - 下記のURLからダウンロードする  
        [https://github.com/agkr234/quakelive-server-standards/archive/refs/heads/mknr-lan.zip](https://github.com/agkr234/quakelive-server-standards/archive/refs/heads/mknr-lan.zip)

        - gitのCLIを使ったことがあるならgit cloneでダウンロードしてもok

2. QLサーバーに使うポート番号を変える。
    - quakelive-server-standards\\_mknrserver にある docker-compose.yml をテキストエディタで開く。
    - ports: の欄にある "27960:27960/udp # game port・・・" のところを編集。
        - 左側の数字のみを変える。　例：27965でゲームサーバーを立てたい → 27965:27960/udp
        - **QLクライアントと同じポート番号を使うとサーバーに繋げなくなるので注意**
          - **QLクライアント**の起動オプションに +set net_port 27999 などQLサーバーに使わないポート番号を設定しておくことをおススメします。

3. コンテナを起動する
    - コマンドプロンプトを開いて quakelive-server-standards\\_mknrserver に移動する  
    ```cd /d ダウンロードしたディレクトリ\quakelive-server-standards\_mknrserver```  
      - 例: ```cd /d C:\Users\makinero\quakelive-server-standards\_mknrserver```
    - docker-compose でコンテナを起動する  
      以下のコマンドを入力すると自動で docker imageの取得＋コンテナの立ち上げ を行ってくれます。
        ```
        docker-compose up --build
        ```
        

## Q&A - サーバー操作方法 
前提：コマンドプロンプトで操作する
- コンテナ関連
  - コンテナを停止したい
    ```
    Ctrl+C を同時押し (docker-compose up --build をしたコマンドプロンプトで)
    ```
    - またはquakelive-server-standards\\_mknrserverに移動して、
    ```
    docker-compose down
    ```
  - コンテナ内(mknrserver_ctf1_1)をbashで操作したい  
    ```
    docker exec -it mknrserver_ctf1_1 bash
    ```
  - コンテナ内から抜け出したい
    ```
    exit (コンテナ内のbashで)
    ```
    - または、  
    ```
    Ctrl+P+Q を同時押し
    ```
    
- QLサーバーのコンソール関連
  - QLサーバーのコンソールに入りたい  
    ```
    docker attach mknrserver_ctf1_1
    ```
  - QLサーバーのコンソールから抜け出したい  
    ```
    Ctrl+P+Q を同時押し
    ```

## Q&A - その他
- コンフィグを弄りたい  
 → quakelive-server-standards\_mknrserver にある autoexec.cfg を開いて弄る

## docker使う利点
- コンテナが落ちたら勝手に再起動してくれる。
- dockerを導入できればあとは自動でQLサーバーを構築してくれる。
  - さらに他のゲームサーバーのdocker用ファイルがまとまってれば、同じようにdocker-compose up --buildだけで起動できる。
- 他の人も同じようなQLサーバーを簡単に構築できる。

## Todo
- workshopファイルをコンテナ起動時に自動ダウンロード
  - QLサーバーに搭載されてるダウンロード機能は壊れてるので自動でダウンロードしてくれない。
- 多目的モード用のQLサーバー
  - 現状の問題点: 一つのコンテナ(QLサーバー)につき1モードを想定して設計されているので、他のmodeがvoteできない。
  - おそらく身内用だといろんなmodeをvoteできるほうがいいと思うのでちょっと弄ってみます。
