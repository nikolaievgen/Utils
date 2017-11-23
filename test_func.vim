function! GetBufferList()
	redir =>buflist
	silent! ls!
	redir END
	return buflist
endfunction
