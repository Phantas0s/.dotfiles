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

### Mount device with read/write permissions

`mnt <device> <folder="/mnt/external">`

### Unmount every devices in a specific folder recursively

`umnt <folder="/mnt/">`

### Mount mtp filesystem

`mntmtp <device_number> <folder="~/mnt/">`

### Umount mtp filesystem

`umntmtp <folder="~/mnt/">`

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

## Network

### Ports

`ports`

List of port opens, fuzzy searchable via fzf

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

`imgresizeall <extension> <width>`
Resize every images with the same extension in the current folder

`imgoptimize <file>`
Optimize the image (conv -strip -interlace Plane -quality 85%) and create a new image

`Imgoptimize <file>`
Optimize the image (conv -strip -interlace Plane -quality 85%) and *replace* the image

`imgoptimizeall <extension>`
Optimize the images with same extension in current folder(conv -strip -interlace Plane -quality 85%) and create new images

`Imgoptimizeall *.<extension>`
Optimize the images with same extension in current folder(conv -strip -interlace Plane -quality 85%) and *replace* them


### Image resize all

`imgresize <extension> <width>`
Resize every images with the extension `<extention>` in the current folder.
Use Image resize (see above)

### Image convert to jpg

`imgconvjpg <source>`

Require imagemagick.

Convert source to a jpg image

### Convert all jpg image in the current folder to webp (by copy)

`imgwebp`

## Git 

`gtD <tag_name> <remote>`

Delete a tag locally AND on the remote. `<remote>` argument is not mandatory, default `origin`.

`gtd <tag_name> <remote>`

Delete a tag ONLY on the remote. `<remote>` argument is not mandatory, default `origin`.

### FZF 

`fmux`

Let you choose a tmuxp config

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

## Programming Languages

### Clojure

`initKondo`

Init kondo-clj for a clojure project with boot.

## Other

### File system

`mkcd`

Create a folder like `mkdir -p` and goes in it.

### File system

`updatezsh`

### Antibody 

Update antibody plugins 

### Prompt Performance

`promptspeed`

Display the time for the prompt to appear when opening a new zsh instance

``

### Productivity

`pom`

Calculate number of pomodoro done for a specific duration.

Arguments:

1. Number of hours
2. Number of minutes
3. (optional) Duration of one pomodoro (default: 25 min)

## Fun

### Term displays

`matrix`

Display... the matrix!

`pipes` 

Remember the OpenGL pipes screensaver on windows 9*? The same in the terminal. [source](https://github.com/iiPlasma/dots/blob/master/bin/bin/pipes).


### Term Colors

`colorblocks` 

Display the main terminal colors configured, in nice blocks. [source](https://github.com/iiPlasma/dots/blob/master/bin/bin/colorblocks).

`colorcards` 

Display all the terminal colors configured, in nice panes. [source](https://github.com/iiPlasma/dots/blob/master/bin/bin/colorcards).

