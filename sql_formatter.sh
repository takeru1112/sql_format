#!/bin/bash

# SQLファイルの整形を行う
# 1️ 一行コメント（--で始まるもの）を削除する
# 2️ sqlファイルの改行をすべて削除
# 3️ Create文とAlter文、複数行コメント(/*)の頭に改行を入れる

# 指定されたディレクトリ内のSQLファイルをすべて整形する
# $1: ディレクトリパス
SQL_FILE=$1/*.sql

for file in $SQL_FILE; do
    echo $file
    # 一行コメントを削除
    sed -i -e 's/--.*$//g' $file

    # 改行を削除
    tr -d '\n' <$file >$file.tmp
    mv $file.tmp $file

    # Create文とAlter文、複数行コメントの頭に改行を入れる
    sed -i -e 's/CREATE/\nCREATE/g' $file
    sed -i -e 's/ALTER/\nALTER/g' $file
    sed -i -e 's/\/\*/\n\/\*/g' $file
done
