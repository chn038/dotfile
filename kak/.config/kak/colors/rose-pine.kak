# Rosé Pine palette — main/dark
declare-option str rp_base           "rgb:191724"
declare-option str rp_surface        "rgb:1f1d2e"
declare-option str rp_overlay        "rgb:26233a"
declare-option str rp_muted          "rgb:6e6a86"
declare-option str rp_subtle         "rgb:908caa"
declare-option str rp_text           "rgb:e0def4"
declare-option str rp_love           "rgb:eb6f92"
declare-option str rp_gold           "rgb:f6c177"
declare-option str rp_rose           "rgb:ebbcba"
declare-option str rp_pine           "rgb:31748f"
declare-option str rp_foam           "rgb:9ccfd8"
declare-option str rp_iris           "rgb:c4a7e7"
declare-option str rp_highlight_low  "rgb:21202e"
declare-option str rp_highlight_med  "rgb:403d52"
declare-option str rp_highlight_high "rgb:524f67"

# Tree-sitter faces
set-face global ts_attribute                    "%opt{rp_gold}"
set-face global ts_comment                      "%opt{rp_muted}+i"
set-face global ts_comment_unused               "%opt{rp_muted}+is"
set-face global ts_conceal                      "%opt{rp_iris}+i"
set-face global ts_constant                     "%opt{rp_gold}"
set-face global ts_constant_builtin_boolean     "%opt{rp_foam}"
set-face global ts_constant_character           "%opt{rp_rose}"
set-face global ts_constant_macro               "%opt{rp_iris}"
set-face global ts_constructor                  "%opt{rp_foam}"
set-face global ts_diff_plus                    "%opt{rp_foam}"
set-face global ts_diff_minus                   "%opt{rp_love}"
set-face global ts_diff_delta                   "%opt{rp_pine}"
set-face global ts_diff_delta_moved             "%opt{rp_iris}"
set-face global ts_error                        "%opt{rp_love}+b"
set-face global ts_function                     "%opt{rp_rose}"
set-face global ts_function_builtin             "%opt{rp_rose}+i"
set-face global ts_function_macro               "%opt{rp_iris}"
set-face global ts_hint                         "%opt{rp_foam}+b"
set-face global ts_info                         "%opt{rp_foam}+b"
set-face global ts_keyword                      "%opt{rp_iris}"
set-face global ts_keyword_conditional          "%opt{rp_iris}+i"
set-face global ts_keyword_control_conditional  "%opt{rp_iris}+i"
set-face global ts_keyword_control_directive    "%opt{rp_iris}+i"
set-face global ts_keyword_control_import       "%opt{rp_iris}+i"
set-face global ts_keyword_directive            "%opt{rp_iris}+i"
set-face global ts_keyword_storage              "%opt{rp_iris}"
set-face global ts_keyword_storage_modifier     "%opt{rp_iris}"
set-face global ts_keyword_storage_modifier_mut "%opt{rp_iris}"
set-face global ts_keyword_storage_modifier_ref "%opt{rp_foam}"
set-face global ts_label                        "%opt{rp_foam}+i"
set-face global ts_namespace                    "%opt{rp_pine}+i"
set-face global ts_operator                     "%opt{rp_foam}"
set-face global ts_property                     "%opt{rp_foam}"
set-face global ts_punctuation                  "%opt{rp_subtle}"
set-face global ts_punctuation_special          "%opt{rp_foam}"
set-face global ts_special                      "%opt{rp_iris}"
set-face global ts_string                       "%opt{rp_foam}"
set-face global ts_string_regex                 "%opt{rp_rose}"
set-face global ts_string_regexp                "%opt{rp_rose}"
set-face global ts_string_escape                "%opt{rp_gold}"
set-face global ts_string_special               "%opt{rp_iris}"
set-face global ts_string_special_path          "%opt{rp_foam}"
set-face global ts_string_special_symbol        "%opt{rp_iris}"
set-face global ts_string_symbol                "%opt{rp_rose}"
set-face global ts_tag                          "%opt{rp_iris}"
set-face global ts_tag_error                    "%opt{rp_love}"
set-face global ts_text                         "%opt{rp_text}"
set-face global ts_type                         "%opt{rp_foam}"
set-face global ts_type_enum_variant            "%opt{rp_rose}"
set-face global ts_type_enum_variant_builtin    "%opt{rp_rose}+i"
set-face global ts_variable                     "%opt{rp_text}"
set-face global ts_variable_builtin             "%opt{rp_rose}"
set-face global ts_variable_other_member        "%opt{rp_pine}"
set-face global ts_variable_parameter           "%opt{rp_rose}+i"
set-face global ts_warning                      "%opt{rp_gold}+b"

# Markup
set-face global ts_markup_bold                  "%opt{rp_gold}+b"
set-face global ts_markup_heading               "%opt{rp_iris}"
set-face global ts_markup_heading_1             "%opt{rp_iris}"
set-face global ts_markup_heading_2             "%opt{rp_foam}"
set-face global ts_markup_heading_3             "%opt{rp_rose}"
set-face global ts_markup_heading_4             "%opt{rp_gold}"
set-face global ts_markup_heading_5             "%opt{rp_pine}"
set-face global ts_markup_heading_6             "%opt{rp_foam}"
set-face global ts_markup_heading_marker        "%opt{rp_gold}+b"
set-face global ts_markup_italic                "%opt{rp_rose}+i"
set-face global ts_markup_list_checked          "%opt{rp_foam}"
set-face global ts_markup_list_numbered         "%opt{rp_pine}+i"
set-face global ts_markup_list_unchecked        "%opt{rp_foam}"
set-face global ts_markup_list_unnumbered       "%opt{rp_iris}"
set-face global ts_markup_link_label            "%opt{rp_pine}"
set-face global ts_markup_link_url              "%opt{rp_foam}+u"
set-face global ts_markup_link_uri              "%opt{rp_foam}+u"
set-face global ts_markup_link_text             "%opt{rp_pine}"
set-face global ts_markup_quote                 "%opt{rp_muted}"
set-face global ts_markup_raw                   "%opt{rp_foam}"
set-face global ts_markup_strikethrough         "%opt{rp_muted}+s"
set-face global ts_spell                        "%opt{rp_iris}"


# rose-pine theme for Kakoune
#
# Ported from the fresh-editor palette (palettes/fresh/rose-pine.json), shared across the justaperlhacker editor themes.
#
# Generated by scripts/gen_themes.py -- do not edit by hand.

# Code
face global value         rgb:f6c177
face global type          rgb:9ccfd8
face global variable      rgb:e0def4
face global identifier    rgb:e0def4
face global module        rgb:9ccfd8
face global function      rgb:ebbcba
face global method        rgb:ebbcba
face global string        rgb:f6c177
face global keyword       rgb:31748f
face global operator      rgb:908caa
face global attribute     rgb:9ccfd8
face global comment       rgb:908caa+i
face global documentation rgb:a4a0bc
face global meta          rgb:eb6f92
face global builtin       rgb:eb6f92+b
face global constant      rgb:f6c177
face global error         rgb:eb6f92

# Markup
face global title  rgb:31748f+b
face global header rgb:9ccfd8
face global mono   rgb:6e6a86
face global block  rgb:31748f
face global link   rgb:31748f+u
face global bullet rgb:f6c177
face global list   rgb:e0def4

# UI
face global Default                rgb:e0def4,rgb:191724
face global PrimarySelection       rgb:191724,rgb:403d52
face global SecondarySelection     rgb:e0def4,rgb:2d2b39
face global PrimaryCursor          rgb:191724,rgb:e0def4+fg
face global SecondaryCursor        rgb:191724,rgb:6e6a86+fg
face global PrimaryCursorEol       rgb:191724,rgb:e0def4+fg
face global SecondaryCursorEol     rgb:191724,rgb:6e6a86+fg
face global MatchingChar           rgb:ebbcba+b
face global MenuForeground         rgb:191724,rgb:31748f
face global MenuBackground         rgb:e0def4,rgb:1f1d2e
face global MenuInfo               rgb:31748f
face global Information            rgb:191724,rgb:f6c177
face global InlineInformation      rgb:e0def4,rgb:1f1d2e
face global Error                  rgb:191724,rgb:eb6f92
face global DiagnosticError        rgb:eb6f92
face global DiagnosticWarning      rgb:f6c177
face global StatusLine             rgb:908caa,rgb:1f1d2e
face global StatusLineMode         rgb:908caa+b
face global StatusLineInfo         rgb:908caa
face global StatusLineValue        rgb:908caa+b
face global StatusCursor           rgb:191724,rgb:e0def4
face global Prompt                 rgb:31748f
face global BufferPadding          rgb:737182,rgb:191724
face global LineNumbers            rgb:6e6a86,rgb:191724
face global LineNumberCursor       rgb:31748f,rgb:191724+b
face global LineNumbersWrapped     rgb:6e6a86,rgb:191724+i
face global Whitespace             rgb:26233a+f
face global WrapMarker             rgb:26233a+f
face global Search                 rgb:191724,rgb:f6c177
face global DiffAdd                rgb:c4a7e7,rgb:1c2a2a
face global DiffRm                 rgb:eb6f92,rgb:2e1f2a
face global DiffMeta               rgb:31748f,rgb:2a2440
face global MercurialCommitComment rgb:908caa

face global InfoDefault               Information
face global InfoBlock                 Information
face global InfoBlockQuote            Information
face global InfoBullet                Information
face global InfoHeader                Information
face global InfoLink                  Information
face global InfoLinkMono              Information
face global InfoMono                  Information
face global InfoRule                  Information
face global InfoDiagnosticError       Information
face global InfoDiagnosticHint        Information
face global InfoDiagnosticInformation Information
face global InfoDiagnosticWarning     Information
