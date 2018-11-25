# Scripts for zsh

Doc for my zsh scripts (`scripts.zsh`).

## System

### Update system

`updatesys`

Update:
* Go binaries
* Composer global install
* Official Arch linux packages (via Aurman or yay if installed ; otherwise pacman)
* AUR packages (via Aurman or yay if installed)

### Disk backup

`dback <disk source> <disk output>`

Use dd to copy an entire hard disk to another disk output. Ask questions to be sure you know what you are doing :)
Way safer than using pure dd without any warning message...

### Create ssh key

`sshcreate <name>`

Create a new ssh key at `~/.ssh/<name>` with permission 700.
The name will be put as comment in the key as well.

## Archives

### Extraction

`extract <archive_file>`

Extract any archive automatically. Require `tar` and `unzip`.

### Compression
`compress <folder>`

Compress a folder - output `tar.gz`

## Database

### Postgres

These commands need `pv` to be installed.

#### Dump
`postgdump <database> <user> <host>`

Create a dump of a database. Include clean up and create dabatase when imported back.

The file created will be `<database>`.sql

`<user>` and `<host>` are not mandatory, default `postgres` and `localhost`.

#### Import 
`postgimport <table_name> <user> <host>`

Import a database. If the file is called `database.sql`, it will try to import into the database named `database`.

`<user>` and `<host>` are not mandatory, default `postgres` and `localhost`.

**THE OPERATION WILL OVERWRITE ALL DATA!**

## Images

### Screenshot 

`screenshot <win|scr|area>`

Take a screenshot of the window / screen / area respectively.

### Image size

`imgsize <img>`

Display width / height of an image.

### Image resize 

`imgresize <source> <width>`
Resize and create a new image named `<source>_<width>.<extension>` following aspect ratio.

### Image convert to jpg

`imgconvjpg <source>`

Require imagemagick.

Convert source to a jpg image

## Git 

`gtD <tag_name> <remote>`

Delete a tag locally AND on the remote. `<remote>` argument is not mandatory, default `origin`.

### FZF meets Git

#### Checkout 

`fgco`

Require fzf of course :)
Checkout local or remote branch via FZF

#### Logs

`fgl`

Simple way to fuzzy search in the log tree.

### Stash

`fstash`

Fuzzy search in the stash list. 

## Other

`thriftgen`

Generate thrift config via thrift on local (docker image doesn't work...)

## Fun

`matrix`

Display... the matrix!

`colorblocks` 

Display the main terminal colors configured, in nice blocks. [source](https://github.com/iiPlasma/dots/blob/master/bin/bin/colorblocks).

`colorpanes` 

Display all the terminal colors configured, in nice panes. [source](https://github.com/iiPlasma/dots/blob/master/bin/bin/colorpanes).

`pipes` 

Remember the OpenGL pipes screensaver on windows 9*? The same in the terminal. [source](https://github.com/iiPlasma/dots/blob/master/bin/bin/pipes).

