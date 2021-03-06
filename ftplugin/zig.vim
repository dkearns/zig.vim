" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif

let b:did_ftplugin = 1

let s:cpo_orig = &cpo
set cpo&vim

" Recomended code style, no tabs and 4-space indentation
setlocal expandtab
setlocal tabstop=8
setlocal softtabstop=4
setlocal shiftwidth=4

setlocal formatoptions-=t formatoptions+=croql

setlocal suffixesadd=.zig,.zir
setlocal makeprg=zig\ build

if has("comments")
    setlocal comments=:///,://!,://,:\\\\
    setlocal commentstring=//\ %s
endif

if has('find_in_path')
	let &l:includeexpr='substitute(v:fname, "^([^.])$", "\1.zig", "")'
	let &l:include='\v(\@import>|\@cInclude>|^\s*\#\s*include)'
	let &l:define='\v(<fn>|<const>|<var>|^\s*\#\s*define)'
endif

if has('eval')
	execute 'setlocal path+=' . json_decode(system('zig env'))['std_dir']
endif

let b:undo_ftplugin = "setl et< ts< sts< sw< fo< sua< mp< com< cms<"

let &cpo = s:cpo_orig
unlet s:cpo_orig
