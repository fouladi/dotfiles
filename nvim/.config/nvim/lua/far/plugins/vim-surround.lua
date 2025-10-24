-- The three "core" operations of `add/delete/change` can be done
-- with the keymaps:
--     * ys{motion}{char}
--     * ds{char}
--     * cs{target}{replacement}
-- , respectively. For the following examples, * will denote the
-- cursor position:
--
--     Old text                    Command         New text
-- ---------------------------------------------------------------------
--     surr*ound_words             ysiw)           (surround_words)
--     *make strings               ys$"            "make strings"
--     [delete ar*ound me!]        ds]             delete around me!
--     remove <b>HTML t*ags</b>    dst             remove HTML tags
--     surr*ound_words             csw"            "surround_words"
--     'change quot*es'            cs'"            "change quotes"
return {
    "tpope/vim-surround",
}
