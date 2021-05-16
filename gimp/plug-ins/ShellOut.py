#!/usr/bin/env python

'''
ShellOut.py
call an external program passing the active layer as a temp file.  Windows Only(?)
Author:
Rob Antonishen
Version:
0.8 better complex external program handling
0.7 fixed file save bug where all files were png regardless of extension
0.6 modified to allow for a returned layer that is a different size 
   than the saved layer for
  0.5 file extension parameter in program list.
0.4 modified to support many optional programs.
this script is modelled after the mm extern LabCurves trace plugin 
by Michael Munzert http://www.mm-log.com/lab-curves-gimp
and thanks to the folds at gimp-chat has grown a bit ;)
License:
This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; version 3 of the License.
This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.
The GNU Public License is available at
http://www.gnu.org/copyleft/gpl.html
'''

from gimpfu import *
import shutil
import subprocess
import os, sys
import tempfile

TEMP_FNAME = "ShellOutTempFile"

def nikWine(name, ndir = None, exe = None):
  if ndir is None:
    ndir = name
  if exe is None:
    exe = name  
  return [name,
          ["wine", os.path.expanduser("~/win32/drive_c/Program Files/Google/Nik Collection/" +
                                      os.path.join(ndir, exe + ".exe"))],
          "tif"]

def nikWineHDRHook(tmpfile, ext):
  shutil.move(os.path.expandvars("$HOME/win32/drive_c/users/$USER/My Documents/" + TEMP_FNAME + "_HDR." + ext),
              tmpfile)

#program list function (globals are evil)
def listcommands(option=None):
  #
  # Insert additonal shell command into this list.  They will show up in the drop menu in this order.
  # Use the syntax:
  # ["Menu Label", "command", "ext"]
  # 
  # Where what gets executed is command fileame so include and flags needed in the command.
  programlist = [
  nikWine("Analog Efex Pro 2"),
  nikWine("Color Efex Pro 4"),
  nikWine("Dfine 2", "Dfine 2", "Dfine2"),
  nikWine("HDR Efex Pro 2") + [nikWineHDRHook],
  nikWine("Silver Efex Pro 2"),
  nikWine("Sharpener Pro 3 (Output Sharpener)", "Sharpener Pro 3", "SHP3OS"),
  nikWine("Sharpener Pro 3 (Raw Pre Sharpener)", "Sharpener Pro 3", "SHP3RPS"),
  nikWine("Viveza 2"),
  ["",[],""]
  ]
  
  if option == None: # no parameter return menu list, otherwise return the appropaiate array
    menulist = []
    for i in programlist:
      if i[0] != "":
        menulist.append(i[0])
    return menulist
  else:
    return programlist[option]
	

def plugin_main(image, drawable, visible, command):
  pdb.gimp_image_undo_group_start(image)
  
  # Copy so the save operations doesn't affect the original
  if visible == 0:
    # Save in temporary.  Note: empty user entered file name
    temp = pdb.gimp_image_get_active_drawable(image)
  else:
    # Get the current visible
    temp = pdb.gimp_layer_new_from_visible(image, image, "Visible")
    image.add_layer(temp, 0)

  buffer = pdb.gimp_edit_named_copy(temp, "ShellOutTemp")

  #save selection if one exists
  hassel = pdb.gimp_selection_is_empty(image) == 0
  if hassel:
    savedsel = pdb.gimp_selection_save(image)

  tempimage = pdb.gimp_edit_named_paste_as_new(buffer)
  pdb.gimp_buffer_delete(buffer)
  if not tempimage:
    raise RuntimeError
  pdb.gimp_image_undo_disable(tempimage)

  tempdrawable = pdb.gimp_image_get_active_layer(tempimage)
  
  #get the program to run and filetype.
  progtorun = listcommands(command)
  
  # Use temp file names from gimp, it reflects the user's choices in gimp.rc
  # change as indicated if you always want to use the same temp file name
  # tempfilename = pdb.gimp_temp_name(progtorun[2])
  tempfiledir = tempfile.gettempdir()
  tempfilename = os.path.join(tempfiledir, TEMP_FNAME + "." + progtorun[2])

  # !!! Note no run-mode first parameter, and user entered filename is empty string
  pdb.gimp_progress_set_text ("Saving a copy")
  pdb.gimp_file_save(tempimage, tempdrawable, tempfilename, tempfilename)

  # Build command line call
  args = progtorun[1] + [tempfilename]

  # Invoke external command
  pdb.gimp_progress_set_text ("calling " + progtorun[0] + "...")
  pdb.gimp_progress_pulse()

  d = dict(os.environ)
  d["WINEPREFIX"] = os.path.expanduser("~/win32")
  child = subprocess.Popen(args, shell=False, env=d)
  child.wait()

  if len(progtorun) > 3:
    progtorun[3](tempfilename, progtorun[2])

  # put it as a new layer in the opened image
  try:
    newlayer2 = pdb.gimp_file_load_layer(tempimage, tempfilename)
  except:
    RuntimeError
	
  tempimage.add_layer(newlayer2,-1)
  buffer = pdb.gimp_edit_named_copy(newlayer2, "ShellOutTemp")

  if visible == 0:
    drawable.resize(newlayer2.width,newlayer2.height,0,0)
    sel = pdb.gimp_edit_named_paste(drawable, buffer, 1)
    drawable.translate((tempdrawable.width-newlayer2.width)/2,(tempdrawable.height-newlayer2.height)/2)
  else:
    temp.resize(newlayer2.width,newlayer2.height,0,0)
    sel = pdb.gimp_edit_named_paste(temp, buffer, 1)
    temp.translate((tempdrawable.width-newlayer2.width)/2,(tempdrawable.height-newlayer2.height)/2)

  pdb.gimp_buffer_delete(buffer)
  # pdb.gimp_edit_clear(temp)	
  pdb.gimp_floating_sel_anchor(sel)

  #load up old selection
  if hassel:
    pdb.gimp_selection_load(savedsel)
    image.remove_channel(savedsel)
  
  # cleanup
  os.remove(tempfilename)  # delete the temporary file
  gimp.delete(tempimage)   # delete the temporary image

  # Note the new image is dirty in Gimp and the user will be asked to save before closing.
  pdb.gimp_image_undo_group_end(image)
  gimp.displays_flush()


register(
        "python_fu_shellout",
        "Call an external program",
        "Call an external program",
        "Rob Antonishen",
        "Copyright 2011 Rob Antonishen",
        "2011",
        "<Image>/Script-Fu/ShellOut...",
        "RGB*, GRAY*", 
        [ (PF_RADIO, "visible", "Layer:", 1, (("new from visible", 1),("current layer",0))),
          (PF_OPTION,"command",("Program:"),0,listcommands())
        ],
        [],
        plugin_main,
        )

main()
