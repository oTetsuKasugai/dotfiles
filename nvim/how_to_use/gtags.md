" File: gtags.vim
" Author: Tama Communications Corporation
" Version: 0.6.8
" Last Modified: Nov 9, 2015
"
" Copyright and license
" ---------------------
" Copyright (c) 2004, 2008, 2010, 2011, 2012, 2014, 2015
" Tama Communications Corporation
"
" This file is part of GNU GLOBAL.
"
" This program is free software: you can redistribute it and/or modify
" it under the terms of the GNU General Public License as published by
" the Free Software Foundation, either version 3 of the License, or
" (at your option) any later version.
" 
" This program is distributed in the hope that it will be useful,
" but WITHOUT ANY WARRANTY; without even the implied warranty of
" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
" GNU General Public License for more details.
" 
" You should have received a copy of the GNU General Public License
" along with this program.  If not, see <http://www.gnu.org/licenses/>.
"
" Overview
" --------
" The gtags.vim plug-in script integrates the GNU GLOBAL source code tagging system
" with Vim. About the details, see http://www.gnu.org/software/global/.
"
" Installation
" ------------
" Drop the file in your plug-in directory or source it from your vimrc.
" To use this script, you need GLOBAL-6.0 or later installed in your machine.
"
" Usage
" -----
" First of all, you must execute gtags(1) at the root of source directory
" to make tag files. Assuming that your source directory is '/var/src',
" it is necessary to execute the following commands.
"
"	$ cd /var/src
"	$ gtags
"
" And you will find three tag files in the directory.
"
"	$ ls G*
"	GPATH	GRTAGS	GTAGS
"
" General form of Gtags command is as follows:
"
"	:Gtags [option] pattern
"
" You can use all options of global(1) except for the -c, -p, -u and
" all long name options. They are sent to global(1) as is.
"
" To go to 'func', you can say
"
"       :Gtags func
"
" Input completion is available. If you forgot the name of a function
" but recall only some characters of the head, please input them and
" press <TAB> key.
"
"       :Gtags fu<TAB>
"       :Gtags func			<- Vim will append 'nc'.
"
" If you omitted an argument, vim ask it as follow:
"
"       Gtags for pattern: <current token>
"
" Inputting 'main' to the prompt, vim executes `global -x main',
" parse the output, list located objects in the quickfix window
" and load the first entry. The quickfix window shows like this:
"
"      gozilla/gozilla.c|200| main(int argc, char **argv)
"      gtags-cscope/gtags-cscope.c|124| main(int argc, char **argv)
"      gtags-parser/asm_scan.c|2056| int main()
"      gtags-parser/gctags.c|157| main(int argc, char **argv)
"      gtags-parser/php.c|2116| int main()
"      gtags/gtags.c|152| main(int argc, char **argv)
"      [Quickfix List]
"
" You can go to any entry using quickfix command.
"
" :cn'
"      go to the next line.
"
" :cp'
"      go to the previous line.
"
" :ccN'
"      go to the Nth line.
"
" :cl'
"      list all lines.
"
" You can see a help for quickfix like this:
"
"          :h quickfix
"
" You can use POSIX regular expression too. It requires more execution time though.
"
"       :Gtags ^[sg]et_
"
" It will match to both of 'set_value' and 'get_value'.
"
" To go to the referenced point of 'func', add -r option.
"
"       :Gtags -r func
"
" To go to any symbols which are not defined in GTAGS, try this.
"
"       :Gtags -s func
"
" To go to any string other than symbol, try this.
"
"       :Gtags -g ^[sg]et_
"
" This command accomplishes the same function as grep(1) but is more convenient
" because it retrieves an entire directory structure.
"
" To get list of objects in a file 'main.c', use -f command.
"
"       :Gtags -f main.c
"
" If you are editing `main.c' itself, you can use '%' instead.
"
"       :Gtags -f %
"
" You can get a list of files whose path include specified pattern.
" For example:
"
"       :Gtags -P /vm/			<- all files under 'vm' directory.
"       :Gtags -P \.h$			<- all include files.
"	:Gtags -P init			<- all paths includes 'init'
"
" If you omitted an argument and input only <ENTER> key to the prompt,
" vim shows list of all files in the project.
"
" Since all short options are sent to global(1) as is, you can 
" use the -i, -o, -O, and so on.
" 
" For example, if you want to ignore case distinctions in pattern.
"
"       :Gtags -gi paTtern
"
" It will match to both of 'PATTERN' and 'pattern'.
"
" If you want to search a pattern which starts with a hyphen like '-C'
" then you can use the -e option like grep(1).
"
"	:Gtags -ge -C
"
" By default, Gtags command search only in source files. If you want to
" search in both source files and text files, or only in text files then
"
"	:Gtags -go pattern		# both source and text
"	:Gtags -gO pattern		# only text file
"
" See global(1) for other options.
"
" The Gtagsa (Gtags + append) command is almost the same as Gtags command.
" But it differs from Gtags in that it adds the results to the present list.
" If you want to get the union of ':Gtags -d foo' and ':Gtags -r foo' then
" you can invoke the following commands:
"
"       :Gtags  -d foo
"       :Gtagsa -r foo
"
" The GtagsCursor command brings you to the definition or reference of
" the current token. If it is a definition, you are taken to the references.
" If it is a reference, you are taken to the definitions.
"
"       :GtagsCursor
"
" If you have the hypertext generated by htags(1) then you can display
" the same place on mozilla browser. Let's load mozilla and try this:
"
"       :Gozilla
"
" If you want to load vim with all main()s then following command line is useful.
"
"	% vim '+Gtags main'
"
" Also see the chapter of 'vim editor' of the on-line manual of GLOBAL.
"
"	% info global
"
" The following custom variables are available.
"
" Gtags_VerticalWindow    open windows vitically
" Gtags_Auto_Map          use a suggested key-mapping
" Gtags_Auto_Update       keep tag files up-to-date automatically
" Gtags_No_Auto_Jump      don't jump to the first tag at the time of search
" Gtags_Close_When_Single close quickfix windows in case of single tag
"
" You can use the variables like follows:
"
"	[$HOME/.vimrc]
"	let Gtags_Auto_Map = 1
"
" If you want to use the tag stack, please use gtags-cscope.vim.
" You can use the plug-in together with this script.
"
