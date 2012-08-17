"=========================================================================
"
"	FileName: PLVim.vim
"  Describle: PanLee's personal vim-script
"   Commands: :SetPath
"				set path
"             :UnsetPath
"				unset path
"	  Author: PanLee
"	   Email: 45177659@qq.com
"
"	 Created:  Tue Aug 12 23:33:00
"	 Version: 1.0
"	 History: 1.0 | Tue Aug 12 23:33:00
"
"=====================totaltime & totalline===============================

"set path or unset path

command! SetPath call PL_SetPath()
command! UnsetPath call PL_UnsetPath()

func! PL_SetPath()
	if &filetype=="c"
		set path+=D:\MinGW\include
		echo "path set ok"
	elseif &filetype=="cpp"
		set path+=D:\MinGW\lib\gcc\mingw32\4.6.2\include\c++
		echo "path set ok"
	else
		echo "not a c/cpp file"
	endif
endfunc

func! PL_UnsetPath()
	set path=
	echo "path unset ok"
endfunc

"abbrevation for some words
iabbrev teh the
iabbrev itn int
iabbrev #incldue #include
iabbrev mian() main()
iabbrev chr char
iabbrev naem name
