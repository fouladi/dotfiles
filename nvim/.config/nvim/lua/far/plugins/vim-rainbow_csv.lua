return {
    "mechatroner/rainbow_csv",
-- |Filetype       | Separator     | Extension | Properties                                          |
-- |---------------|---------------|-----------|-----------------------------------------------------|
-- |csv            | , (comma)     | .csv      | Ignored inside double-quoted fields                 |
-- |tsv            | \t (TAB)      | .tsv .tab |                                                     |
-- |csv_semicolon  | ; (semicolon) |           | Ignored inside double-quoted fields                 |
-- |csv_whitespace | whitespace    |           | Consecutive whitespaces are merged                  |
-- |csv_pipe       | |      (pipe) |           |                                                     |
-- |rfc_csv        | , (comma)     |           | Same as "csv" but allows multiline fields           |
-- |rfc_semicolon  | ; (semicolon) |           | Same as "csv_semicolon" but allows multiline fields |
}
