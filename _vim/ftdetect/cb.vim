" Vim syntax file
" Language:     Codebeamer
" Maintainer:   Christian Roesch
" Filenames:    *.cb

if exists("b:current_syntax")
  finish
endif

if !exists('main_syntax')
  let main_syntax = 'cb'
endif

runtime! syntax/html.vim
unlet! b:current_syntax

if !exists('g:markdown_fenced_languages')
  let g:markdown_fenced_languages = []
endif
for s:type in map(copy(g:markdown_fenced_languages),'matchstr(v:val,"[^=]*$")')
  if s:type =~ '\.'
    let b:{matchstr(s:type,'[^.]*')}_subtype = matchstr(s:type,'\.\zs.*')
  endif
  exe 'syn include @markdownHighlight'.substitute(s:type,'\.','','g').' syntax/'.matchstr(s:type,'[^.]*').'.vim'
  unlet! b:current_syntax
endfor
unlet! s:type

syn sync minlines=10
syn case ignore

syn match markdownLineStart "^[<@]\@!" nextgroup=@markdownBlock,htmlSpecialChar

syn cluster markdownBlock contains=cbH1,cbH2,cbH3,cbH4,cbH5,cbListMarker,markdownCodeBlock,cbRule,cbComment
syn cluster markdownInline contains=markdownLinkText,markdownItalic,markdownBold,markdownCode,markdownEscape,@htmlTop,markdownError

syn region cbH1 matchgroup=markdownHeadingDelimiter start="!1"           end="$" keepend oneline contains=@markdownInline,markdownAutomaticLink contained
syn region cbH2 matchgroup=markdownHeadingDelimiter start="\%\(!!!\|!2\)" end="$" keepend oneline contains=@markdownInline,markdownAutomaticLink contained
syn region cbH3 matchgroup=markdownHeadingDelimiter start="!\%(!\(!\)\@!\|3\)"   end="$" keepend oneline contains=@markdownInline,markdownAutomaticLink contained
syn region cbH4 matchgroup=markdownHeadingDelimiter start="!\([1-3!]\)\@!4\?"          end="$" keepend oneline contains=@markdownInline,markdownAutomaticLink contained
syn region cbH5 matchgroup=markdownHeadingDelimiter start="!5"           end="$" keepend oneline contains=@markdownInline,markdownAutomaticLink contained

syn region cbComment start="//" end="$" contained

syn match cbListMarker "[*#]\+\%(\s\+\S\)\@=" contained

syn match cbRule "----[-]*$" contained

syn region markdownIdDeclaration matchgroup=markdownLinkDelimiter start="^ \{0,3\}!\=\[" end="\]:" oneline keepend nextgroup=markdownUrl skipwhite
syn match markdownUrl "\S\+" nextgroup=markdownUrlTitle skipwhite contained
syn region markdownUrl matchgroup=markdownUrlDelimiter start="<" end=">" oneline keepend nextgroup=markdownUrlTitle skipwhite contained
syn region markdownUrlTitle matchgroup=markdownUrlTitleDelimiter start=+"+ end=+"+ keepend contained
syn region markdownUrlTitle matchgroup=markdownUrlTitleDelimiter start=+'+ end=+'+ keepend contained
syn region markdownUrlTitle matchgroup=markdownUrlTitleDelimiter start=+(+ end=+)+ keepend contained

syn region markdownLinkText matchgroup=markdownLinkTextDelimiter start="!\=\[\%(\_[^]]*]\%( \=[[(]\)\)\@=" end="\]\%( \=[[(]\)\@=" keepend nextgroup=markdownLink,markdownId skipwhite contains=@markdownInline,markdownLineStart
syn region markdownLink matchgroup=markdownLinkDelimiter start="(" end=")" contains=markdownUrl keepend contained
syn region markdownId matchgroup=markdownIdDelimiter start="\[" end="\]" keepend contained
syn region markdownAutomaticLink matchgroup=markdownUrlDelimiter start="<\%(\w\+:\|[[:alnum:]_+-]\+@\)\@=" end=">" keepend oneline

syn region markdownItalic start="''" end="''" keepend contains=markdownLineStart
syn region markdownBold start="__" end="__" keepend contains=markdownLineStart,markdownItalic
syn region markdownCode matchgroup=markdownCodeDelimiter start="{{" end="}}" keepend contained
syn region markdownCode matchgroup=markdownCodeDelimiter start="{{{" end="}}}" keepend contained

if main_syntax ==# 'cb'
  for s:type in g:markdown_fenced_languages
    exe 'syn region markdownHighlight'.substitute(matchstr(s:type,'[^=]*$'),'\..*','','').' matchgroup=markdownCodeDelimiter start="^\s*```'.matchstr(s:type,'[^=]*').'\>.*$" end="^\s*```\ze\s*$" keepend contains=@markdownHighlight'.substitute(matchstr(s:type,'[^=]*$'),'\.','','g')
  endfor
  unlet! s:type
endif

syn match markdownEscape "\\[][\\`*_{}()#+.-]"
syn match markdownError "\w\@<=_\w\@="

hi def link cbH1                    htmlH1
hi def link cbH2                    htmlH2
hi def link cbH3                    htmlH3
hi def link cbH4                    htmlH4
hi def link cbH5                    htmlH5
hi def link markdownHeadingDelimiter      Delimiter
hi def link cbListMarker            htmlTagName
hi def link cbComment            Comment
hi def link cbRule                  PreProc

hi def link markdownLinkText              htmlLink
hi def link markdownIdDeclaration         Typedef
hi def link markdownId                    Type
hi def link markdownAutomaticLink         markdownUrl
hi def link markdownUrl                   Float
hi def link markdownUrlTitle              String
hi def link markdownIdDelimiter           markdownLinkDelimiter
hi def link markdownUrlDelimiter          htmlTag
hi def link markdownUrlTitleDelimiter     Delimiter

hi def link markdownItalic                htmlItalic
hi def link markdownBold                  htmlBold
hi def link markdownBoldItalic            htmlBoldItalic
hi def link markdownCodeDelimiter         String
hi def link markdownCode String

hi def link markdownEscape                Special
hi def link markdownError                 Error

let b:current_syntax = "cb"
if main_syntax ==# 'cb'
  unlet main_syntax
endif

" vim:set sw=2:
