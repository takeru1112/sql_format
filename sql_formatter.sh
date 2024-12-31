#!/bin/bash

# SQLファイルの整形を行う
# 1️ 一行コメント（--で始まるもの）を削除する
# 2️ sqlファイルの改行をすべて削除
# 3️ Create文とAlter文、複数行コメント(/*)の頭に改行を入れる

# 指定されたディレクトリ内のSQLファイルをすべて整形する
# 置換結果は他のファイルに出力する（元ファイルは書き換えない）
# $1: ディレクトリパス
SQL_FILE=$1/*.sql

for file in $SQL_FILE; do
    echo $file
    output_file="${file%.sql}_formatted.sql"
    
    # 一行コメントを削除
    sed 's/--.*$//g' $file |

    # 改行を削除
    tr -d '\n' |

    # Create文とAlter文、複数行コメントの頭に改行を入れる
    sed 's/CREATE/\nCREATE/g' |
    sed 's/ALTER/\nALTER/g' |
    sed 's/\/\*/\n\/\*/g' > $output_file
done
