#!/bin/bash
get_dbs() {
  ls ~/Library/Application\ Support/MobileSync/Backup/*/3d0d7e5fb2ce288813306e4d4636395e047a3d28
}

query="SELECT
  DATETIME(date + 978307200, 'unixepoch', 'localtime') as Date,
  h.id as \"Phone Number\",
  text as Text
FROM message m, handle h
WHERE
  h.rowid = m.handle_id AND
  m.text LIKE '%$1%'
ORDER BY m.rowid ASC"

run_query() {
  echo "${query};" | sqlite3 "$1"
}

IFS=$'\n'
for db in `get_dbs`; do
  run_query "$db"
done
