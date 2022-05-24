# Scripts for Zsh

Doc for my Zsh scripts (`./scripts.zsh`) and the scripts using fzf (`./scripts_fzf.sh`).

The arguments are indicated between `<>`, for example `<arg>`.

If the argument has a value, it's the default one (and therefore the argument is not mandatory). For example: `<arg=default>`.

## System

### Update system

* `updatesys`

Call a bash script and update:
* Go binaries.
* Composer global install.
* Official Arch linux packages.
* AUR packages using Yay.

### Disk backup

* `dback <disk source> <disk output>`

Use dd to copy an entire hard disk to another disk output. Ask questions to be sure you know what you are doing :)
Way safer than using pure dd without any warning message... (and its weird syntax!).

### System backup

* `backup` - Backup all my data to

### Create ssh key

* `sshcreate <name>`

Create a new ssh key at `~/.ssh/<name>` with permission 700.
The name will be put as comment in the key as well.

### Screen

* `screenres <screen_number>`

Display screen resolution.

Each of your screen has a number. That's what `<screen_number>` is.

### Mount device with read/write permissions

* `mnt <device> <folder="/mnt/external">`

### Unmount every devices in a specific folder recursively

* `umnt <folder="/mnt/">`

### Mount mtp filesystem

* `mntmtp <device_number> <folder="~/mnt/">`

### Umount mtp filesystem

* `umntmtp <folder="~/mnt/">`

### Pacman Search

* `fpac`

Search with fzf in all the available Pacman packages.

## Navigation

* `fd`

Display the directory stack with fzf. Jump to the directory when one selected

Only work with the following alias:

```
alias d='dirs -v'
for index ({1..9}) alias "$index"="cd +${index}"; unset index # directory stack
```

## Neovim

* `vinfo`

Open info documentation files in Neovim.

Need the plugin 'alx741/vinfo'

* `vimgolf <challenge_id> <key>`

Run vimgolf via docker (doesn't need anything else than docker).

If you have an env variable named `$VIM_GOLF_KEY` with the value of your key, you just need to do: `vimgolf <challenge_id>`.

Have fun!

## Tmux

* `fmux`

Let you choose a tmuxp config with fzf and run it.

* `ftmuxp`

Same as fmux but propose to create a new tmux session too and rename URxvt tab automatically with name of tmuxp config file.

* `ftmux`

Attach a session you can choose with fzf.

## Archives

### Extraction

* `extract <archive_file>`

Extract any archive automatically. Require `tar` and `unzip`.

* `mkextract <archive_file>`

Create a folder with the name of the archive, extract the archive in.

### Compression

* `compress <files>...`

Compress one or multiple folder or files.

## Database

### Postgres

These commands need `pv` to be installed.

#### Dump

* `postgdump <database> <user=postgres> <host=localhost>`

Create a dump of a database. Include clean up and create dabatase when imported back.

The file created will be `<database>`.sql

#### Import

* `postgimport <table_name> <user=postgres> <host=localhost>`

Import a database. If the file is called `database.sql`, it will try to import into the database named `database`.

**THIS OPERATION WILL OVERWRITE ALL DATA!**

## Network

### Ports

* `ports`

List of port opens, fuzzy searchable via fzf

## Video

* `screencast <output_file> <screen_number>`

Take a screencast and save it in the `<output_file>`.

The choice of screen with `<screen_number>` is very much tailored for my own needs, with a small screen as first screen and big screen as second.

* `vidvolup <input_file> <percentage_volume_increase> <output_file=output.mkv`

Increase the volume of a video and save the new video as <output_file>. For example, `vidvolup input.mkv 100 output.mkv` will increase the volume of 100% and output the result as output.mkv. In fact, the volume will be doubled.

## Images

### Screenshot

* `screenshot <win|scr|area>`

Take a screenshot of the window / screen / area respectively.

### Image size

* `imgsize <img>`

Display width / height of an image.

### Image resize

* `imgresize <source> <width> <overwrite>`
Resize and create a new image, named `<source>_<width>.<extension>` following aspect ratio.

If `<overwrite>` argument has a value, the image won't be rename and will overwrite the original.

* `imgresizeall <extension> <width>`
Resize every images with the same extension in the current folder

* `imgoptimize <file>`
Optimize the image (`conv -strip -interlace Plane -quality 85%`) and create a new image

* `Imgoptimize <file>`
Optimize the image (`conv -strip -interlace Plane -quality 85%`).

* `imgoptimizeall <extension>`
Optimize the images with same extension in current folder(`conv -strip -interlace Plane -quality 85%`) and create new images

* `Imgoptimizeall *.<extension>`
Optimize the images with same extension in current folder(`conv -strip -interlace Plane -quality 85%`) and *replace* them

### Image resize all

* `imgresize <extension> <width>`
Resize every images with the extension `<extention>` in the current folder.
Use Image resize (see above)

### Image convert to jpg

* `imgtojpg <source>`

Require imagemagick.

Convert any image to jpg.

### Image convert to Webp

* `imgtowebp <images>`

Require cwebp.

Convert all images given as parameters to webp.

## Music

* `wav2flac <args>`

Get one or more argument. Convert a wav file into a flac file using ffmpeg.

* `rmwav2flac <args>`

Get one or more argument. Convert a wav file into a flac file using ffmpeg.

Delete the wav file when conversion done.

## Internet

* `duckduckgo <search>`

Search on duckduckgo using the text-based browser lynx.

* `wikipedia <search>`

Search on wikipedia using the text-based browser lynx.

## Download

### Youtube dl

* `ydl <video_url>`

Download a video with best quality from Youtube.

* `ydlp <playlist_url>`

Download a playlist from Youtube.

## Git

* `gtrm <tag_name> <remote=origin>`

Delete a tag locally AND on the remote.

* `githeat`

Display a git heatmap

* `fgco`

List all branches with fzf and allow you to switch to it (via `git checkout`).

* `fstash`

List the stashes with fzf.

* `CTRL+d` - Shows diff of stash against HEAD
* `CTRL+b` - Checks the stash out as a branch (for easier merging)

### FZF meets Git

#### Checkout

* `fgco`

Require fzf of course :)
Checkout local or remote branch via FZF

#### Logs

* `fgl`

Simple way to fuzzy search in the log tree.

### Stash

* `fstash`

Fuzzy search in the stash list.

## Programming Languages

### Clojure

* `initKondo`

Init kondo-clj for a clojure project with boot.

## Shell

### Prompt Performance

* `promptspeed`

Display the time for the prompt to appear when opening a new zsh instance

* ``

### Auto completed commands in Zsh

* `zshcomp`

Display all autocompleted command in zsh.

First column: command name
Second column: completion function

### Command History

* `historystat`

Display the command more often used in the shell

## Manual & Help

* `cheat <command>`

Display command cheatsheet from [cheat.sh](cheat.sh).

## Other

### Project Management

* `touchproject <name>`

Create a [taskell](https://github.com/smallhadroncollider/taskell) project `<name>`.

### File system

* `mkcd`

Create a folder like `mkdir -p` and jump to it.

* `mkmv`

Move a file or a folder, and create the filepath if it doesn't exist.

* `mkcp`

Copy a file or a folder, and create the filepath if it doesn't exist.

### Productivity

* `pom <hours> <minutes> <duration=25>`

Calculate number of pomodoro done for a specific time in hour(s) and minute(s).

### Knowledge Management

* `fm <map_path>`

Open a freemind map with all output stream redirected to /dev/null

* `fmind`

List all my freemind mindmaps and allow to open the one you want.

### Math

* `calcul <operation>`

Calculate a mathematical operation. For example: `calcul "2 * 3"`.

### Internet

* `tiny <url>`

Use tinyurl to shorten the `<url>`.

* `serve <port=8888>`

Create a server using Python with specific port

## Fun

### Term displays

* `matrix`

Display... the matrix!

* `pipes`

Remember the OpenGL pipes screensaver on windows 9*? The same in the terminal. [source](https://github.com/iiPlasma/dots/blob/master/bin/bin/pipes).

### Term Colors

* `colorblocks`

Display the main terminal colors configured, in nice blocks. [source](https://github.com/iiPlasma/dots/blob/master/bin/bin/colorblocks).

* `colorcards`

Display all the terminal colors configured, in nice panes. [source](https://github.com/iiPlasma/dots/blob/master/bin/bin/colorcards).

