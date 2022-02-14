# Session
Session save: <leader>ss
Session close: <leader>sc
Session load: <leader>sl

# Browser
Open Browser: <Ctrl>t
Mark file: mf
Edit marked files: me
Change work dir: cd
Show hidden: gh
Go up dir: -
Delete file: D

# Fzf
Find files: <Ctrl>p
List buffers: <Ctrl>b
Find line in all buffers: <Ctrl>/
Grep all files: <Ctrl>f

# Buffer
Open buffer in split: <Ctrl>x or <Ctrl>v

# Window
Split window: <Ctrl>+w,v  <Ctrl>+w,s
Reset window: <Ctrl>+w,=
Close window: <Ctrl>w,c
Close all others: <Ctrl>w,o

# Save/Close
Close: <leader>q
Save: <leader>w

# Sorting
* Sort by column
    - https://stackoverflow.com/questions/14076275/sort-numerically-in-vi-editor
    1. Columnize
	    - :%!column -t
    2. Sort (e.g. column 3)
	    - %!sort -n -k 3
