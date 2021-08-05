" vim:fdm=marker
" Vim Color File
" Name:       onedark.vim
" Maintainer: https://github.com/joshdick/onedark.vim/
" License:    The MIT License (MIT)
" Based On:   https://github.com/MaxSt/FlatColor/

" A companion [vim-airline](https://github.com/bling/vim-airline) theme is available at: https://github.com/joshdick/airline-onedark.vim

" Color Reference {{{

" The following colors were measured inside Atom using its built-in inspector.

" +---------------------------------------------+
" |  Color Name  |         RGB        |   Hex   |
" |--------------+--------------------+---------|
" | Black        | rgb(40, 44, 52)    | #282c34 |
" |--------------+--------------------+---------|
" | White        | rgb(171, 178, 191) | #abb2bf |
" |--------------+--------------------+---------|
" | Light Red    | rgb(224, 108, 117) | #e06c75 |
" |--------------+--------------------+---------|
" | Dark Red     | rgb(190, 80, 70)   | #be5046 |
" |--------------+--------------------+---------|
" | Green        | rgb(152, 195, 121) | #98c379 |
" |--------------+--------------------+---------|
" | Light Yellow | rgb(229, 192, 123) | #e5c07b |
" |--------------+--------------------+---------|
" | Dark Yellow  | rgb(209, 154, 102) | #d19a66 |
" |--------------+--------------------+---------|
" | Blue         | rgb(97, 175, 239)  | #61afef |
" |--------------+--------------------+---------|
" | Magenta      | rgb(198, 120, 221) | #c678dd |
" |--------------+--------------------+---------|
" | Cyan         | rgb(86, 182, 194)  | #56b6c2 |
" |--------------+--------------------+---------|
" | Gutter Grey  | rgb(76, 82, 99)    | #4b5263 |
" |--------------+--------------------+---------|
" | Comment Grey | rgb(92, 99, 112)   | #5c6370 |
" +---------------------------------------------+

" }}}

" Initialization {{{

highlight clear

if exists("syntax_on")
  syntax reset
endif

set t_Co=256

let g:colors_name="onedark"

" Set to "256" for 256-color terminals, or
" set to "16" to use your terminal emulator's native colors
" (a 16-color palette for this color scheme is available; see
" < https://github.com/joshdick/onedark.vim/blob/master/README.md >
" for more information.)
if !exists("g:onedark_termcolors")
  let g:onedark_termcolors = 256
endif

" Not all terminals support italics properly. If yours does, opt-in.
if !exists("g:onedark_terminal_italics")
  let g:onedark_terminal_italics = 0
endif

" This function is based on one from FlatColor: https://github.com/MaxSt/FlatColor/
" Which in turn was based on one found in hemisu: https://github.com/noahfrederick/vim-hemisu/
let s:group_colors = {} " Cache of default highlight group settings, for later reference via `onedark#extend_highlight`
function! s:h(group, style, ...)
  if (a:0 > 0) " Will be true if we got here from onedark#extend_highlight
    let s:highlight = s:group_colors[a:group]
    for style_type in ["fg", "bg", "sp"]
      if (has_key(a:style, style_type))
        let l:default_style = (has_key(s:highlight, style_type) ? s:highlight[style_type] : { "cterm16": "NONE", "cterm": "NONE", "gui": "NONE" })
        let s:highlight[style_type] = extend(l:default_style, a:style[style_type])
      endif
    endfor
    if (has_key(a:style, "gui"))
      let s:highlight.gui = a:style.gui
    endif
  else
    let s:highlight = a:style
    let s:group_colors[a:group] = s:highlight " Cache default highlight group settings
  endif

  if g:onedark_terminal_italics == 0
    if has_key(s:highlight, "cterm") && s:highlight["cterm"] == "italic"
      unlet s:highlight.cterm
    endif
    if has_key(s:highlight, "gui") && s:highlight["gui"] == "italic"
      unlet s:highlight.gui
    endif
  endif

  if g:onedark_termcolors == 16
    let l:ctermfg = (has_key(s:highlight, "fg") ? s:highlight.fg.cterm16 : "NONE")
    let l:ctermbg = (has_key(s:highlight, "bg") ? s:highlight.bg.cterm16 : "NONE")
  else
    let l:ctermfg = (has_key(s:highlight, "fg") ? s:highlight.fg.cterm : "NONE")
    let l:ctermbg = (has_key(s:highlight, "bg") ? s:highlight.bg.cterm : "NONE")
  endif

  execute "highlight" a:group
    \ "guifg="   (has_key(s:highlight, "fg")    ? s:highlight.fg.gui   : "NONE")
    \ "guibg="   (has_key(s:highlight, "bg")    ? s:highlight.bg.gui   : "NONE")
    \ "guisp="   (has_key(s:highlight, "sp")    ? s:highlight.sp.gui   : "NONE")
    \ "gui="     (has_key(s:highlight, "gui")   ? s:highlight.gui      : "NONE")
    \ "ctermfg=" . l:ctermfg
    \ "ctermbg=" . l:ctermbg
    \ "cterm="   (has_key(s:highlight, "cterm") ? s:highlight.cterm    : "NONE")
endfunction

" public {{{

function! onedark#set_highlight(group, style)
  call s:h(a:group, a:style)
endfunction

function! onedark#extend_highlight(group, style)
  call s:h(a:group, a:style, 1)
endfunction

" }}}

" }}}

" Color Variables {{{

let s:overrides = get(g:, "onedark_color_overrides", {})

" visual_black: Black out selected text in 16-color visual mode
let s:colors = {
      \ "red": get(s:overrides, "red", { "gui": "#E06C75", "cterm": "203", "cterm16": "1" }),
      \ "dark_red": get(s:overrides, "dark_red", { "gui": "#BE5046", "cterm": "1", "cterm16": "9" }),
      \ "green": get(s:overrides, "green", { "gui": "#98C379", "cterm": "114", "cterm16": "2" }),
      \ "dark_green": get(s:overrides, "dark_green", { "gui": "#203D49", "cterm": "23", "cterm16": "2" }),
      \ "yellow": get(s:overrides, "yellow", { "gui": "#E5C07B", "cterm": "220", "cterm16": "3" }),
      \ "dark_yellow": get(s:overrides, "dark_yellow", { "gui": "#D19A66", "cterm": "214", "cterm16": "11" }),
      \ "blue": get(s:overrides, "blue", { "gui": "#61AFEF", "cterm": "33", "cterm16": "4" }),
      \ "light_blue": get(s:overrides, "light_blue", { "gui": "#579AE0", "cterm": "75", "cterm16": "12" }),
      \ "purple": get(s:overrides, "purple", { "gui": "#C678DD", "cterm": "176", "cterm16": "5" }),
      \ "cyan": get(s:overrides, "cyan", { "gui": "#5FD7D7", "cterm": "80", "cterm16": "14" }),
      \ "visual_black": get(s:overrides, "visual_black", { "gui": "NONE", "cterm": "NONE", "cterm16": "0" }),
      \ "black": get(s:overrides, "black", { "gui": "#18191C", "cterm": "234", "cterm16": "0" }),
      \ "cursor_grey": get(s:overrides, "cursor_grey", { "gui": "#2C323C", "cterm": "236", "cterm16": "8" }),
      \ "visual_grey": get(s:overrides, "visual_grey", { "gui": "#3E4452", "cterm": "237", "cterm16": "15" }),
      \ "menu_grey": get(s:overrides, "menu_grey", { "gui": "#3E4452", "cterm": "237", "cterm16": "8" }),
      \ "gutter_fg_grey": get(s:overrides, "gutter_fg_grey", { "gui": "#4B5263", "cterm": "238", "cterm16": "15" }),
      \ "special_grey": get(s:overrides, "special_grey", { "gui": "#3B4048", "cterm": "238", "cterm16": "15" }),
      \ "comment_grey": get(s:overrides, "comment_grey", { "gui": "#5C6370", "cterm": "244", "cterm16": "15" }),
      \ "light_grey": get(s:overrides, "light_grey", { "gui": "#CDCDCD", "cterm": "250", "cterm16": "7" }),
      \ "white": get(s:overrides, "white", { "gui": "#ABB2BF", "cterm": "252", "cterm16": "7" }),
      \ "vertsplit": get(s:overrides, "vertsplit", { "gui": "#3C4046", "cterm": "59", "cterm16": "15" }),
      \}

" }}}

" Terminal Colors {{{

let g:terminal_ansi_colors = [
  \ s:colors.black.gui, s:colors.red.gui, s:colors.green.gui, s:colors.yellow.gui,
  \ s:colors.blue.gui, s:colors.purple.gui, s:colors.cyan.gui, s:colors.white.gui,
  \ s:colors.visual_grey.gui, s:colors.dark_red.gui, s:colors.green.gui, s:colors.dark_yellow.gui,
  \ s:colors.blue.gui, s:colors.purple.gui, s:colors.cyan.gui, s:colors.comment_grey.gui
\]

" }}}

" Syntax Groups (descriptions and ordering from `:h w18`) {{{

call s:h("Comment", { "fg": s:colors.comment_grey, "gui": "italic", "cterm": "italic" }) " any comment
call s:h("Constant", { "fg": s:colors.cyan }) " any constant
call s:h("String", { "fg": s:colors.green }) " a string constant: "this is a string"
call s:h("Character", { "fg": s:colors.green }) " a character constant: 'c', '\n'
call s:h("Number", { "fg": s:colors.dark_yellow }) " a number constant: 234, 0xff
call s:h("Boolean", { "fg": s:colors.dark_yellow }) " a boolean constant: TRUE, false
call s:h("Float", { "fg": s:colors.dark_yellow }) " a floating point constant: 2.3e10
call s:h("Identifier", { "fg": s:colors.red }) " any variable name
call s:h("Function", { "fg": s:colors.blue }) " function name (also: methods for classes)
call s:h("Statement", { "fg": s:colors.purple }) " any statement
call s:h("Conditional", { "fg": s:colors.purple }) " if, then, else, endif, switch, etc.
call s:h("Repeat", { "fg": s:colors.purple }) " for, do, while, etc.
call s:h("Label", { "fg": s:colors.purple }) " case, default, etc.
call s:h("Operator", { "fg": s:colors.purple }) " sizeof", "+", "*", etc.
call s:h("Keyword", { "fg": s:colors.red }) " any other keyword
call s:h("Exception", { "fg": s:colors.purple }) " try, catch, throw
call s:h("PreProc", { "fg": s:colors.yellow }) " generic Preprocessor
call s:h("Include", { "fg": s:colors.blue }) " preprocessor #include
call s:h("Define", { "fg": s:colors.purple }) " preprocessor #define
call s:h("Macro", { "fg": s:colors.purple }) " same as Define
call s:h("PreCondit", { "fg": s:colors.yellow }) " preprocessor #if, #else, #endif, etc.
call s:h("Type", { "fg": s:colors.yellow }) " int, long, char, etc.
call s:h("StorageClass", { "fg": s:colors.yellow }) " static, register, volatile, etc.
call s:h("Structure", { "fg": s:colors.yellow }) " struct, union, enum, etc.
call s:h("Typedef", { "fg": s:colors.yellow }) " A typedef
call s:h("Special", { "fg": s:colors.blue }) " any special symbol
call s:h("SpecialChar", {}) " special character in a constant
call s:h("Tag", {}) " you can use CTRL-] on this
call s:h("Delimiter", {}) " character that needs attention
call s:h("SpecialComment", { "fg": s:colors.comment_grey }) " special things inside a comment
call s:h("Debug", {}) " debugging statements
call s:h("Underlined", { "gui": "underline", "cterm": "underline" }) " text that stands out, HTML links
call s:h("Ignore", {}) " left blank, hidden
call s:h("Error", { "fg": s:colors.red }) " any erroneous construct
call s:h("Todo", { "fg": s:colors.purple }) " anything that needs extra attention; mostly the keywords TODO FIXME and XXX

" }}}

" Highlighting Groups (descriptions and ordering from `:h highlight-groups`) {{{
call s:h("ColorColumn", { "bg": s:colors.cursor_grey }) " used for the columns set with 'colorcolumn'
call s:h("Conceal", {}) " placeholder characters substituted for concealed text (see 'conceallevel')
call s:h("Cursor", { "fg": s:colors.black, "bg": s:colors.blue }) " the character under the cursor
call s:h("CursorIM", {}) " like Cursor, but used when in IME mode
call s:h("CursorColumn", { "bg": s:colors.cursor_grey }) " the screen column that the cursor is in when 'cursorcolumn' is set
if &diff
  " Don't change the background color in diff mode
  call s:h("CursorLine", { "gui": "underline" }) " the screen line that the cursor is in when 'cursorline' is set
else
  call s:h("CursorLine", { "bg": s:colors.cursor_grey }) " the screen line that the cursor is in when 'cursorline' is set
endif
call s:h("Directory", { "fg": s:colors.blue }) " directory names (and other special names in listings)
call s:h("DiffAdd", { "bg": s:colors.green, "fg": s:colors.black }) " diff mode: Added line
call s:h("DiffChange", { "fg": s:colors.yellow, "gui": "underline", "cterm": "underline" }) " diff mode: Changed line
call s:h("DiffDelete", { "bg": s:colors.red, "fg": s:colors.black }) " diff mode: Deleted line
call s:h("DiffText", { "bg": s:colors.yellow, "fg": s:colors.black }) " diff mode: Changed text within a changed line
if get(g:, 'onedark_hide_endofbuffer', 0)
    " If enabled, will style end-of-buffer filler lines (~) to appear to be hidden.
    call s:h("EndOfBuffer", { "fg": s:colors.black }) " filler lines (~) after the last line in the buffer
endif
call s:h("ErrorMsg", { "fg": s:colors.red }) " error messages on the command line
call s:h("VertSplit", { "fg": s:colors.vertsplit, "bg": s:colors.vertsplit}) " the column separating vertically split windows
call s:h("Folded", { "fg": s:colors.comment_grey }) " line used for closed folds
call s:h("FoldColumn", {}) " 'foldcolumn'
call s:h("SignColumn", {}) " column where signs are displayed
call s:h("IncSearch", { "fg": s:colors.yellow, "bg": s:colors.comment_grey }) " 'incsearch' highlighting; also used for the text replaced with ":s///c"
call s:h("LineNr", { "fg": s:colors.gutter_fg_grey }) " Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
call s:h("CursorLineNr", {}) " Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
call s:h("MatchParen", { "fg": s:colors.black, "bg": s:colors.white, "gui": "underline" }) " The character under the cursor or just before it, if it is a paired bracket, and its match.
call s:h("ModeMsg", {}) " 'showmode' message (e.g., "-- INSERT --")
call s:h("MoreMsg", {}) " more-prompt
call s:h("NonText", { "fg": s:colors.special_grey }) " '~' and '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line).
call s:h("Normal", { "fg": s:colors.white, "bg": s:colors.black }) " normal text
call s:h("Pmenu", { "bg": s:colors.menu_grey }) " Popup menu: normal item.
call s:h("PmenuSel", { "fg": s:colors.black, "bg": s:colors.blue }) " Popup menu: selected item.
call s:h("PmenuSbar", { "bg": s:colors.special_grey }) " Popup menu: scrollbar.
call s:h("PmenuThumb", { "bg": s:colors.white }) " Popup menu: Thumb of the scrollbar.
call s:h("Question", { "fg": s:colors.purple }) " hit-enter prompt and yes/no questions
call s:h("QuickFixLine", { "fg": s:colors.black, "bg": s:colors.yellow }) " Current quickfix item in the quickfix window.
call s:h("Search", { "fg": s:colors.black, "bg": s:colors.yellow }) " Last search pattern highlighting (see 'hlsearch'). Also used for similar items that need to stand out.
call s:h("SpecialKey", { "fg": s:colors.special_grey }) " Meta and special keys listed with ":map", also for text used to show unprintable characters in the text, 'listchars'. Generally: text that is displayed differently from what it really is.
call s:h("SpellBad", { "fg": s:colors.red, "gui": "underline", "cterm": "underline" }) " Word that is not recognized by the spellchecker. This will be combined with the highlighting used otherwise.
call s:h("SpellCap", { "fg": s:colors.dark_yellow }) " Word that should start with a capital. This will be combined with the highlighting used otherwise.
call s:h("SpellLocal", { "fg": s:colors.dark_yellow }) " Word that is recognized by the spellchecker as one that is used in another region. This will be combined with the highlighting used otherwise.
call s:h("SpellRare", { "fg": s:colors.dark_yellow }) " Word that is recognized by the spellchecker as one that is hardly ever used. spell This will be combined with the highlighting used otherwise.
call s:h("StatusLine", { "fg": s:colors.white, "bg": s:colors.cursor_grey }) " status line of current window
call s:h("StatusLineNC", { "fg": s:colors.comment_grey }) " status lines of not-current windows Note: if this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
call s:h("StatusLineTerm", { "fg": s:colors.white, "bg": s:colors.cursor_grey }) " status line of current :terminal window
call s:h("StatusLineTermNC", { "fg": s:colors.comment_grey }) " status line of non-current :terminal window
call s:h("TabLine", { "fg": s:colors.comment_grey }) " tab pages line, not active tab page label
call s:h("TabLineFill", {}) " tab pages line, where there are no labels
call s:h("TabLineSel", { "fg": s:colors.white }) " tab pages line, active tab page label
call s:h("Terminal", { "fg": s:colors.white, "bg": s:colors.black }) " terminal window (see terminal-size-color)
call s:h("Title", { "fg": s:colors.green }) " titles for output from ":set all", ":autocmd" etc.
call s:h("Visual", { "fg": s:colors.visual_black, "bg": s:colors.visual_grey }) " Visual mode selection
call s:h("VisualNOS", { "bg": s:colors.visual_grey }) " Visual mode selection when vim is "Not Owning the Selection". Only X11 Gui's gui-x11 and xterm-clipboard supports this.
call s:h("WarningMsg", { "fg": s:colors.yellow }) " warning messages
call s:h("WildMenu", { "fg": s:colors.black, "bg": s:colors.blue }) " current match in 'wildmenu' completion

" }}}

" Termdebug highlighting for Vim 8.1+ {{{

" See `:h hl-debugPC` and `:h hl-debugBreakpoint`.
call s:h("debugPC", { "bg": s:colors.special_grey }) " the current position
call s:h("debugBreakpoint", { "fg": s:colors.black, "bg": s:colors.red }) " a breakpoint

" }}}

" Language-Specific Highlighting {{{

" C

call s:h("cType", { "fg": s:colors.cyan })
call s:h("cTypedef", { "fg": s:colors.purple })
call s:h("cStructure", { "fg": s:colors.purple })
call s:h("cInclude", { "fg": s:colors.purple })

call s:h("cppType", { "fg": s:colors.cyan })
call s:h("cppSTLtype", { "fg": s:colors.white })

" CSS
call s:h("cssAttrComma", { "fg": s:colors.purple })
call s:h("cssAttributeSelector", { "fg": s:colors.green })
call s:h("cssBraces", { "fg": s:colors.white })
call s:h("cssClassName", { "fg": s:colors.dark_yellow })
call s:h("cssClassNameDot", { "fg": s:colors.dark_yellow })
call s:h("cssDefinition", { "fg": s:colors.purple })
call s:h("cssFontAttr", { "fg": s:colors.dark_yellow })
call s:h("cssFontDescriptor", { "fg": s:colors.purple })
call s:h("cssFunctionName", { "fg": s:colors.blue })
call s:h("cssIdentifier", { "fg": s:colors.blue })
call s:h("cssImportant", { "fg": s:colors.purple })
call s:h("cssInclude", { "fg": s:colors.white })
call s:h("cssIncludeKeyword", { "fg": s:colors.purple })
call s:h("cssMediaType", { "fg": s:colors.dark_yellow })
call s:h("cssProp", { "fg": s:colors.white })
call s:h("cssPseudoClassId", { "fg": s:colors.dark_yellow })
call s:h("cssSelectorOp", { "fg": s:colors.purple })
call s:h("cssSelectorOp2", { "fg": s:colors.purple })
call s:h("cssTagName", { "fg": s:colors.red })

" Fish Shell
call s:h("fishKeyword", { "fg": s:colors.purple })
call s:h("fishConditional", { "fg": s:colors.purple })

" Go
call s:h("goDeclaration", { "fg": s:colors.purple })
call s:h("goBuiltins", { "fg": s:colors.cyan })
call s:h("goFunctionCall", { "fg": s:colors.blue })
call s:h("goVarDefs", { "fg": s:colors.red })
call s:h("goVarAssign", { "fg": s:colors.red })
call s:h("goVar", { "fg": s:colors.purple })
call s:h("goConst", { "fg": s:colors.purple })
call s:h("goType", { "fg": s:colors.yellow })
call s:h("goTypeName", { "fg": s:colors.yellow })
call s:h("goDeclType", { "fg": s:colors.cyan })
call s:h("goTypeDecl", { "fg": s:colors.purple })

" HTML
call s:h("htmlTitle", { "fg": s:colors.white })
call s:h("htmlArg", { "fg": s:colors.dark_yellow })
call s:h("htmlEndTag", { "fg": s:colors.white })
call s:h("htmlH1", { "fg": s:colors.white })
call s:h("htmlLink", { "fg": s:colors.white })
call s:h("htmlSpecialChar", { "fg": s:colors.dark_yellow })
call s:h("htmlSpecialTagName", { "fg": s:colors.red })
call s:h("htmlTag", { "fg": s:colors.white })
call s:h("htmlTagName", { "fg": s:colors.red })

" JavaScript
call s:h("javaScriptBraces", { "fg": s:colors.white })
call s:h("javaScriptFunction", { "fg": s:colors.purple })
call s:h("javaScriptIdentifier", { "fg": s:colors.purple })
call s:h("javaScriptNull", { "fg": s:colors.dark_yellow })
call s:h("javaScriptNumber", { "fg": s:colors.dark_yellow })
call s:h("javaScriptRequire", { "fg": s:colors.cyan })
call s:h("javaScriptReserved", { "fg": s:colors.purple })

call s:h("javaScriptMethod", { "fg": s:colors.blue })
"call s:h("javaScriptType", { "fg": s:colors.red })
"call s:h("javaScriptLabel",{ "fg": s:colors.white })
"call s:h("javaScriptNull", { "fg": s:colors.dark_yellow })
"call s:h("javaScriptHtmlEvents", { "fg": s:colors.yellow })
"call s:h("javaScriptDomElemFuncs", { "fg": s:colors.yellow })
"call s:h("javaScriptHtmlElemAttrs", { "fg": s:colors.yellow })
"call s:h("javaScriptHtmlElemFuncs", { "fg": s:colors.yellow })
"call s:h("javaScriptGlobalObjects", { "fg": s:colors.yellow })

" https://github.com/pangloss/vim-javascript
call s:h("jsArrowFunction", { "fg": s:colors.purple })
call s:h("jsBuiltins", { "fg": s:colors.yellow })
call s:h("jsConditional", { "fg": s:colors.purple })
call s:h("jsClassKeyword", { "fg": s:colors.purple })
call s:h("jsClassMethodType", { "fg": s:colors.purple })
call s:h("jsDocParam", { "fg": s:colors.blue })
call s:h("jsDocTags", { "fg": s:colors.purple })
call s:h("jsExport", { "fg": s:colors.purple })
call s:h("jsExportDefault", { "fg": s:colors.purple })
call s:h("jsExtendsKeyword", { "fg": s:colors.purple })
call s:h("jsFrom", { "fg": s:colors.purple })
call s:h("jsFuncCall", { "fg": s:colors.blue })
call s:h("jsFunction", { "fg": s:colors.purple })
call s:h("jsGenerator", { "fg": s:colors.yellow })
call s:h("jsGlobalObjects", { "fg": s:colors.yellow })
call s:h("jsImport", { "fg": s:colors.purple })
call s:h("jsLabel", { "fg": s:colors.purple })
call s:h("jsModuleAs", { "fg": s:colors.purple })
call s:h("jsModuleWords", { "fg": s:colors.purple })
call s:h("jsModules", { "fg": s:colors.purple })
call s:h("jsNull", { "fg": s:colors.dark_yellow })
call s:h("jsOperator", { "fg": s:colors.white })
call s:h("jsOperatorKeyword", { "fg": s:colors.purple })
call s:h("jsObjectProp", { "fg": s:colors.red })
call s:h("jsRepeat", { "fg": s:colors.purple })
call s:h("jsStorageClass", { "fg": s:colors.purple })
call s:h("jsSuper", { "fg": s:colors.red })
call s:h("jsTemplateBraces", { "fg": s:colors.dark_red })
call s:h("jsTemplateVar", { "fg": s:colors.green })
call s:h("jsTernaryIfOperator", { "fg": s:colors.white })
call s:h("jsThis", { "fg": s:colors.red })
call s:h("jsUndefined", { "fg": s:colors.dark_yellow })
" https://github.com/othree/yajs.vim
call s:h("javascriptArrowFunc", { "fg": s:colors.purple })
call s:h("javascriptClassExtends", { "fg": s:colors.purple })
call s:h("javascriptClassKeyword", { "fg": s:colors.yellow })
call s:h("javascriptDocNotation", { "fg": s:colors.purple })
call s:h("javascriptDocParamName", { "fg": s:colors.blue })
call s:h("javascriptDocTags", { "fg": s:colors.purple })
call s:h("javascriptEndColons", { "fg": s:colors.white })
call s:h("javascriptExport", { "fg": s:colors.purple })
call s:h("javascriptFuncArg", { "fg": s:colors.red })
call s:h("javascriptFuncKeyword", { "fg": s:colors.purple })
call s:h("javascriptIdentifierName", { "fg": s:colors.red })
call s:h("javascriptImport", { "fg": s:colors.purple })
call s:h("javascriptMethodName", { "fg": s:colors.blue })
call s:h("javascriptObjectLabel", { "fg": s:colors.white })
call s:h("javascriptOpSymbols", { "fg": s:colors.white })
call s:h("javascriptPropertyName", { "fg": s:colors.green })
call s:h("javascriptTemplateSB", { "fg": s:colors.dark_red })
call s:h("javascriptVariable", { "fg": s:colors.purple })
call s:h("javascriptBrackets", { "fg": s:colors.white })
call s:h("javascriptClassName", { "fg": s:colors.blue })
call s:h("javascriptPropertyNameString", { "fg": s:colors.green })
call s:h("javascriptLabel", {"fg": s:colors.red }) 
call s:h("javascriptObjectMethodName", {"fg": s:colors.blue }) 
call s:h("javascriptLineComment", {"fg": s:colors.comment_grey }) 

" JSON
call s:h("jsonCommentError", { "fg": s:colors.white })
call s:h("jsonKeyword", { "fg": s:colors.red })
call s:h("jsonBoolean", { "fg": s:colors.dark_yellow })
call s:h("jsonNumber", { "fg": s:colors.dark_yellow })
call s:h("jsonQuote", { "fg": s:colors.white })
call s:h("jsonMissingCommaError", { "fg": s:colors.red, "gui": "reverse" })
call s:h("jsonNoQuotesError", { "fg": s:colors.red, "gui": "reverse" })
call s:h("jsonNumError", { "fg": s:colors.red, "gui": "reverse" })
call s:h("jsonString", { "fg": s:colors.green })
call s:h("jsonStringSQError", { "fg": s:colors.red, "gui": "reverse" })
call s:h("jsonSemicolonError", { "fg": s:colors.red, "gui": "reverse" })

" LESS
call s:h("lessVariable", { "fg": s:colors.purple })
call s:h("lessAmpersandChar", { "fg": s:colors.white })
call s:h("lessClass", { "fg": s:colors.dark_yellow })

" Markdown
call s:h("markdownCode", { "fg": s:colors.green })
call s:h("markdownCodeBlock", { "fg": s:colors.green })
call s:h("markdownCodeDelimiter", { "fg": s:colors.green })
call s:h("markdownHeadingDelimiter", { "fg": s:colors.red })
call s:h("markdownRule", { "fg": s:colors.comment_grey })
call s:h("markdownHeadingRule", { "fg": s:colors.comment_grey })
call s:h("markdownH1", { "fg": s:colors.red })
call s:h("markdownH2", { "fg": s:colors.red })
call s:h("markdownH3", { "fg": s:colors.red })
call s:h("markdownH4", { "fg": s:colors.red })
call s:h("markdownH5", { "fg": s:colors.red })
call s:h("markdownH6", { "fg": s:colors.red })
call s:h("markdownIdDelimiter", { "fg": s:colors.purple })
call s:h("markdownId", { "fg": s:colors.purple })
call s:h("markdownBlockquote", { "fg": s:colors.comment_grey })
call s:h("markdownItalic", { "fg": s:colors.purple, "gui": "italic", "cterm": "italic" })
call s:h("markdownBold", { "fg": s:colors.dark_yellow, "gui": "bold", "cterm": "bold" })
call s:h("markdownListMarker", { "fg": s:colors.red })
call s:h("markdownOrderedListMarker", { "fg": s:colors.red })
call s:h("markdownIdDeclaration", { "fg": s:colors.blue })
call s:h("markdownLinkText", { "fg": s:colors.blue })
call s:h("markdownLinkDelimiter", { "fg": s:colors.white })
call s:h("markdownUrl", { "fg": s:colors.purple })

" Perl
call s:h("perlFiledescRead", { "fg": s:colors.green })
call s:h("perlFunction", { "fg": s:colors.purple })
call s:h("perlMatchStartEnd",{ "fg": s:colors.blue })
call s:h("perlMethod", { "fg": s:colors.purple })
call s:h("perlPOD", { "fg": s:colors.comment_grey })
call s:h("perlSharpBang", { "fg": s:colors.comment_grey })
call s:h("perlSpecialString",{ "fg": s:colors.cyan })
call s:h("perlStatementFiledesc", { "fg": s:colors.red })
call s:h("perlStatementFlow",{ "fg": s:colors.red })
call s:h("perlStatementInclude", { "fg": s:colors.purple })
call s:h("perlStatementScalar",{ "fg": s:colors.purple })
call s:h("perlStatementStorage", { "fg": s:colors.purple })
call s:h("perlSubName",{ "fg": s:colors.yellow })
call s:h("perlVarPlain",{ "fg": s:colors.blue })

" PHP
call s:h("phpVarSelector", { "fg": s:colors.red })
call s:h("phpOperator", { "fg": s:colors.purple })
call s:h("phpParent", { "fg": s:colors.white })
call s:h("phpMemberSelector", { "fg": s:colors.white })
call s:h("phpType", { "fg": s:colors.purple })
call s:h("phpKeyword", { "fg": s:colors.purple })
call s:h("phpClass", { "fg": s:colors.yellow })
call s:h("phpUseClass", { "fg": s:colors.white })
call s:h("phpUseAlias", { "fg": s:colors.white })
call s:h("phpInclude", { "fg": s:colors.purple })
call s:h("phpClassExtends", { "fg": s:colors.green })
call s:h("phpDocTags", { "fg": s:colors.white })
call s:h("phpFunction", { "fg": s:colors.light_blue })
call s:h("phpFunctions", { "fg": s:colors.light_blue })
call s:h("phpMethodsVar", { "fg": s:colors.dark_yellow })
call s:h("phpMagicConstants", { "fg": s:colors.dark_yellow })
call s:h("phpSuperglobals", { "fg": s:colors.red })
call s:h("phpConstants", { "fg": s:colors.dark_yellow })
" call s:h("phpRegion", { "fg": s:colors.light_blue })
call s:h("Delimiter", { "fg": s:colors.dark_red })

" Python

call s:h("pythonImport", {"fg": s:colors.purple})
call s:h("pythonNone", {"fg": s:colors.dark_yellow})

" Ruby
call s:h("rubyBlockParameter", { "fg": s:colors.red})
call s:h("rubyBlockParameterList", { "fg": s:colors.red })
call s:h("rubyClass", { "fg": s:colors.purple})
call s:h("rubyConstant", { "fg": s:colors.yellow})
call s:h("rubyControl", { "fg": s:colors.purple })
call s:h("rubyEscape", { "fg": s:colors.red})
call s:h("rubyFunction", { "fg": s:colors.blue})
call s:h("rubyGlobalVariable", { "fg": s:colors.red})
call s:h("rubyInclude", { "fg": s:colors.blue})
call s:h("rubyIncluderubyGlobalVariable", { "fg": s:colors.red})
call s:h("rubyInstanceVariable", { "fg": s:colors.red})
call s:h("rubyInterpolation", { "fg": s:colors.cyan })
call s:h("rubyInterpolationDelimiter", { "fg": s:colors.red })
call s:h("rubyInterpolationDelimiter", { "fg": s:colors.red})
call s:h("rubyRegexp", { "fg": s:colors.cyan})
call s:h("rubyRegexpDelimiter", { "fg": s:colors.cyan})
call s:h("rubyStringDelimiter", { "fg": s:colors.green})
call s:h("rubySymbol", { "fg": s:colors.cyan})

" Sass
" https://github.com/tpope/vim-haml
call s:h("sassAmpersand", { "fg": s:colors.red })
call s:h("sassClass", { "fg": s:colors.dark_yellow })
call s:h("sassControl", { "fg": s:colors.purple })
call s:h("sassExtend", { "fg": s:colors.purple })
call s:h("sassFor", { "fg": s:colors.white })
call s:h("sassFunction", { "fg": s:colors.cyan })
call s:h("sassId", { "fg": s:colors.blue })
call s:h("sassInclude", { "fg": s:colors.purple })
call s:h("sassMedia", { "fg": s:colors.purple })
call s:h("sassMediaOperators", { "fg": s:colors.white })
call s:h("sassMixin", { "fg": s:colors.purple })
call s:h("sassMixinName", { "fg": s:colors.blue })
call s:h("sassMixing", { "fg": s:colors.purple })
call s:h("sassVariable", { "fg": s:colors.purple })
" https://github.com/cakebaker/scss-syntax.vim
call s:h("scssExtend", { "fg": s:colors.purple })
call s:h("scssImport", { "fg": s:colors.purple })
call s:h("scssInclude", { "fg": s:colors.purple })
call s:h("scssMixin", { "fg": s:colors.purple })
call s:h("scssSelectorName", { "fg": s:colors.dark_yellow })
call s:h("scssVariable", { "fg": s:colors.purple })

" TeX
call s:h("texStatement", { "fg": s:colors.purple })
call s:h("texSubscripts", { "fg": s:colors.dark_yellow })
call s:h("texSuperscripts", { "fg": s:colors.dark_yellow })
call s:h("texTodo", { "fg": s:colors.dark_red })
call s:h("texBeginEnd", { "fg": s:colors.purple })
call s:h("texBeginEndName", { "fg": s:colors.blue })
call s:h("texMathMatcher", { "fg": s:colors.blue })
call s:h("texMathDelim", { "fg": s:colors.blue })
call s:h("texDelimiter", { "fg": s:colors.dark_yellow })
call s:h("texSpecialChar", { "fg": s:colors.dark_yellow })
call s:h("texCite", { "fg": s:colors.blue })
call s:h("texRefZone", { "fg": s:colors.blue })

" TypeScript
call s:h("typescriptReserved", { "fg": s:colors.purple })
call s:h("typescriptEndColons", { "fg": s:colors.white })
call s:h("typescriptBraces", { "fg": s:colors.white })

" XML
call s:h("xmlAttrib", { "fg": s:colors.dark_yellow })
call s:h("xmlEndTag", { "fg": s:colors.red })
call s:h("xmlTag", { "fg": s:colors.red })
call s:h("xmlTagName", { "fg": s:colors.red })

" }}}

" Plugin Highlighting {{{

" airblade/vim-gitgutter
hi link GitGutterAdd    SignifySignAdd
hi link GitGutterChange SignifySignChange
hi link GitGutterDelete SignifySignDelete

" easymotion/vim-easymotion
call s:h("EasyMotionTarget", { "fg": s:colors.red, "gui": "bold", "cterm": "bold" })
call s:h("EasyMotionTarget2First", { "fg": s:colors.yellow, "gui": "bold", "cterm": "bold" })
call s:h("EasyMotionTarget2Second", { "fg": s:colors.dark_yellow, "gui": "bold", "cterm": "bold" })
call s:h("EasyMotionShade",  { "fg": s:colors.comment_grey })

" mhinz/vim-signify
call s:h("SignifySignAdd", { "fg": s:colors.green })
call s:h("SignifySignChange", { "fg": s:colors.yellow })
call s:h("SignifySignDelete", { "fg": s:colors.red })

" neomake/neomake
call s:h("NeomakeWarningSign", { "fg": s:colors.yellow })
call s:h("NeomakeErrorSign", { "fg": s:colors.red })
call s:h("NeomakeInfoSign", { "fg": s:colors.blue })

" tpope/vim-fugitive
call s:h("diffAdded", { "fg": s:colors.green })
call s:h("diffRemoved", { "fg": s:colors.red })

" }}}

" Git Highlighting {{{

call s:h("gitcommitComment", { "fg": s:colors.comment_grey })
call s:h("gitcommitUnmerged", { "fg": s:colors.green })
call s:h("gitcommitOnBranch", {})
call s:h("gitcommitBranch", { "fg": s:colors.purple })
call s:h("gitcommitDiscardedType", { "fg": s:colors.red })
call s:h("gitcommitSelectedType", { "fg": s:colors.green })
call s:h("gitcommitHeader", {})
call s:h("gitcommitUntrackedFile", { "fg": s:colors.cyan })
call s:h("gitcommitDiscardedFile", { "fg": s:colors.red })
call s:h("gitcommitSelectedFile", { "fg": s:colors.green })
call s:h("gitcommitUnmergedFile", { "fg": s:colors.yellow })
call s:h("gitcommitFile", {})
call s:h("gitcommitSummary", { "fg": s:colors.white })
call s:h("gitcommitOverflow", { "fg": s:colors.red })
" VS Code style
" let s:gitdiff_text_color = {"gui": '#B8BFCC', "cterm": "243", "cterm16": "8"}
" let s:gitdiff_dark_red   = {"gui": '#53232A', "cterm": "124", "cterm16": "1"}
" let s:gitdiff_light_red  = {"gui": '#751C22', "cterm": "196", "cterm16": "9"}
" let s:gitdiff_dark_cyan  = {"gui": '#203D49', "cterm": "214", "cterm16": "3"}
" let s:gitdiff_cyan       = {"gui": '#204944', "cterm": "34", "cterm16": "11"}
" let s:gitdiff_light_cyan = {"gui": '#23657A', "cterm": "46", "cterm16": "10"}
" Fork style
let s:gitdiff_text_color = {"gui": '#DDDDDD', "cterm": "253", "cterm16": "7"}
let s:gitdiff_dark_red   = {"gui": '#633F3E', "cterm": "88", "cterm16": "1"}
let s:gitdiff_light_red  = {"gui": '#9F4247', "cterm": "160", "cterm16": "9"}
let s:gitdiff_dark_cyan  = {"gui": '#36513A', "cterm": "28", "cterm16": "2"}
let s:gitdiff_cyan       = {"gui": '#3A6F42', "cterm": "28", "cterm16": "2"}
let s:gitdiff_light_cyan = {"gui": '#388442', "cterm": "34", "cterm16": "2"}

call onedark#set_highlight('DiffAdd'    , { "fg": s:gitdiff_text_color, "bg": s:gitdiff_cyan  })
call onedark#set_highlight('DiffChange' , { "fg": s:gitdiff_text_color, "bg": s:gitdiff_dark_cyan })
call onedark#set_highlight('DiffDelete' , { "fg": s:gitdiff_dark_red,   "bg": s:gitdiff_dark_red    })
call onedark#set_highlight('DiffText'   , { "fg": s:gitdiff_text_color, "bg": s:gitdiff_light_cyan })
call onedark#set_highlight('DiffLine'   , { "fg": s:gitdiff_text_color, "bg": s:gitdiff_cyan  })
call onedark#set_highlight('DiffAdded'  , { "fg": s:gitdiff_text_color, "bg": s:gitdiff_light_cyan })
call onedark#set_highlight('DiffRemoved', { "fg": s:gitdiff_text_color, "bg": s:gitdiff_light_red   })

hi link gitcommitNoBranch gitcommitBranch
hi link gitcommitUntracked gitcommitComment
hi link gitcommitDiscarded gitcommitComment
hi link gitcommitSelected gitcommitComment
hi link gitcommitDiscardedArrow gitcommitDiscardedFile
hi link gitcommitSelectedArrow gitcommitSelectedFile
hi link gitcommitUnmergedArrow gitcommitUnmergedFile

" }}}

" Tree Sitter Group {{{

call s:h("TSInclude", {"fg": s:colors.purple})
call s:h("TSType", {"fg": s:colors.cyan})
call s:h("TSKeyword", {"fg": s:colors.purple})
call s:h("TSKeywordFunction", {"fg": s:colors.purple})
call s:h("TSMethod", {"fg": s:colors.light_blue})
call s:h("TSFunction", {"fg": s:colors.light_blue})
call s:h("TSFuncBuiltin", {"fg": s:colors.cyan})
call s:h("TSParameter", {"fg": s:colors.white})
call s:h("TSConstant", {"fg": s:colors.dark_yellow})
call s:h("TSConstructor", {"fg": s:colors.cyan})
call s:h("TSConstBuiltin", {"fg": s:colors.dark_yellow})
call s:h("TSVariable", {"fg": s:colors.white})
call s:h("TSVariableBuiltin", {"fg": s:colors.yellow})
call s:h("TSPunctBracket", {"fg": s:colors.light_grey})
call s:h("TSPunctSpecial", {"fg": s:colors.dark_red})
call s:h("TSPunctDelimiter", {"fg": s:colors.white})
call s:h("TSTag", {"fg": s:colors.red})
call s:h("TSTagDelimiter", {"fg": s:colors.white})
call s:h("TSTagAttribute", {"fg": s:colors.dark_yellow})
call s:h("TSNone", {"fg": s:colors.white})
call s:h("Error", {"fg": s:colors.white, "bg": s:colors.dark_red})
call s:h("Special", {"fg": s:colors.purple})

" }}}

" Neovim terminal colors {{{

if has("nvim")
  let g:terminal_color_0 =  s:colors.black.gui
  let g:terminal_color_1 =  s:colors.red.gui
  let g:terminal_color_2 =  s:colors.green.gui
  let g:terminal_color_3 =  s:colors.yellow.gui
  let g:terminal_color_4 =  s:colors.blue.gui
  let g:terminal_color_5 =  s:colors.purple.gui
  let g:terminal_color_6 =  s:colors.cyan.gui
  let g:terminal_color_7 =  s:colors.white.gui
  let g:terminal_color_8 =  s:colors.visual_grey.gui
  let g:terminal_color_9 =  s:colors.dark_red.gui
  let g:terminal_color_10 = s:colors.green.gui " No dark version
  let g:terminal_color_11 = s:colors.dark_yellow.gui
  let g:terminal_color_12 = s:colors.blue.gui " No dark version
  let g:terminal_color_13 = s:colors.purple.gui " No dark version
  let g:terminal_color_14 = s:colors.cyan.gui " No dark version
  let g:terminal_color_15 = s:colors.comment_grey.gui
  let g:terminal_color_background = g:terminal_color_0
  let g:terminal_color_foreground = g:terminal_color_7
endif

" }}}

" Must appear at the end of the file to work around this oddity:
" https://groups.google.com/forum/#!msg/vim_dev/afPqwAFNdrU/nqh6tOM87QUJ
set background=dark
