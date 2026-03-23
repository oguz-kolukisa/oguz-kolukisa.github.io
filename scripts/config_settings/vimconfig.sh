#!/bin/bash

set -euo pipefail

VIMRC="$HOME/.vimrc"
MARKER='" ========== OGUZ VIM CONFIG =========='

if grep -qF "$MARKER" "$VIMRC" 2>/dev/null; then
  printf "vim config already present. Skipping.\n"
  exit 0
fi

printf "Adding vim configuration to %s...\n" "$VIMRC"

cat >> "$VIMRC" <<'EOF'
" ========== OGUZ VIM CONFIG ==========

" General
set nocompatible
set encoding=utf-8
set history=1000
set autoread

" UI
set number
set relativenumber
set ruler
set showcmd
set showmode
set cursorline
set wildmenu
set lazyredraw
set showmatch

" Search
set incsearch
set hlsearch
set ignorecase
set smartcase

" Indentation
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set smartindent

" Splits
set splitbelow
set splitright

" Backspace behavior
set backspace=indent,eol,start

" Persistent undo
if has('persistent_undo')
  set undodir=$HOME/.vim/undodir
  set undofile
  silent! call mkdir($HOME.'/.vim/undodir', 'p')
endif

" Syntax highlighting
syntax enable
set background=dark

" Key mappings
let mapleader = " "
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>h :nohlsearch<CR>

" Navigate splits with Ctrl+hjkl
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" ========== END ==========
EOF

printf "vim configuration complete!\n"
