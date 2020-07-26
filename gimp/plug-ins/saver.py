#!/usr/bin/env python

# This is a plug-in intended to be bound to Ctrl-S, and to act as
# a combination of Save, Save as..., Overwrite, and Export...
#
# It saves the image (whether its type would normally require Saving
# or Exporting), and optionally allows for a copy of the image to be
# exported to another file, possibly also scaled differently.
# The copy must be saved to the same directory as the original
# (because juggling two file choosers would make the dialog too huge
# to fit on most screens!)
#
# Regardless of image format chosen, the image will be marked clean
# so you won't get prompted for an unsaved image at quit or close time.
#
# The first time you save a file, you should be prompted for filename
# (even if you opened an existing file).
# After that, the plug-in will remember the filename you set.
# You can always change it with Saver as...
#
# So you can have your XCF with high resolution and all layers,
# and automatically export to a quarter-scale JPEG copy every time
# you save the original. Or you can just overwrite your JPG if
# all you're doing is a quick edit.
#
# The basic save filename follows img.filename.
# The copy, if any, is saved in a parasite:
# export-scaled: filename\npercent\nwidth\nheight

# This plug-in is hosted at https://github.com/akkana/gimp-plugins/blob/master/saver.py

# Copyright 2013,2014 by Akkana Peck, http://www.shallowsky.com/software/
# You may use and distribute this plug-in under the terms of the GPL v2
# or, at your option, any later GPL version.

from gimpfu import *
import gtk
import os
import collections

# Image original size
orig_width = 0
orig_height = 0

# The three gtk.Entry widgets we'll monitor:
percent_e = None
width_e = None
height_e = None

# A way to show errors to the user:
warning_label = None

# A way to turn off notifications while we're calculating
busy = False

def save_both(img, drawable, filename, copyname, width, height):
    '''Save the image, and also save the copy if appropriate,
       doing any duplicating or scaling that might be necessary.
       Returns None on success, else a nonempty string error message.
    '''
    msg = "Saving " + filename

    if copyname:
        if width and height:
            msg += " and a scaled copy, " + copyname
        else:
            msg += " and a copy, " + copyname
    print msg
    # Don't use gimp_message -- it can pop up a dialog.
    # pdb.gimp_message_set_handler(MESSAGE_BOX)
    # pdb.gimp_message(msg)
    # Alternately, could use gimp_progress, though that's not ideal.
    # If you use gimp_progress, don't forget to call pdb.gimp_progress_end()
    #pdb.gimp_progress_set_text(msg)

    # Is there any point to pushing and popping the context?
    #gimp.context_pop()

    # Set up the parasite with information about the copied image,
    # so it will be saved with the main XCF image.
    if copyname:
        if (width and height):
            percent = width * 100.0 / img.width
            # XXX note that this does not guard against changed aspect ratios.
            parastring = '%s\n%d\n%d\n%d' % (copyname, percent, width, height)
        else:
            parastring = '%s\n100.0\nNone\nNone' % (copyname)

        print "Saving parasite", parastring
        para = img.attach_new_parasite('export-copy', 1, parastring)
        # The second argument is is_persistent

        # Also make sure that copyname is a full path (if filename is).
        copypath = os.path.split(copyname)
        if not copypath[0] or len(copypath) == 1:
            filepath = os.path.split(filename)
            if len(filepath) > 1 and filepath[0]:
                print "Turning", copyname, "into a full path:",
                copyname = os.path.join(filepath[0], copyname)
                print copyname

    # Now the parasite is safely attached, and we can save.
    # Alas, we can't attach the JPEG settings parasite until after
    # we've saved the copy, so that won't get saved with the main image
    # though it will be attached to the image and remembered in
    # this session, and the next time we save it should be remembered.

    def is_xcf(thefilename):
        base, ext = os.path.splitext(thefilename)
        ext = ext.lower()
        if ext == '.gz' or ext == '.bz2':
            base, ext = os.path.splitext(base)
            ext = ext.lower()
        return (ext == '.xcf')

    # First, save the original image.
    if is_xcf(filename) or len(img.layers) < 2:
        pdb.gimp_file_save(img, drawable, filename, filename)
    else:
        # It's not XCF and it has multiple layers.
        # We need to make a new image and flatten it.
        copyimg = pdb.gimp_image_duplicate(img)
        # Don't actually flatten since that will prevent saving transparent png.
        #copyimg.flatten()
        pdb.gimp_image_merge_visible_layers(copyimg, CLIP_TO_IMAGE)
        pdb.gimp_file_save(copyimg, copyimg.active_layer, filename, filename)
        gimp.delete(copyimg)

    # We've done the important part, so mark the image clean.
    img.filename = filename
    pdb.gimp_image_clean_all(img)

    # If we don't have to save a copy, return.
    if not copyname:
        return None

    # We'll need a new image if the copy is non-xcf and we have more
    # than one layer, or if we're scaling.
    if (width and height):
        # We're scaling!
        copyimg = pdb.gimp_image_duplicate(img)
        copyimg.scale(width, height)
        print "Scaling to", width, 'x', height
        print "Set parastring to", parastring, "(end of parastring)"

    elif len(img.layers) > 1 and not is_xcf(copyname):
        # We're not scaling, but we still need to flatten.
        copyimg = pdb.gimp_image_duplicate(img)
        # copyimg.flatten()
        pdb.gimp_image_merge_visible_layers(copyimg, CLIP_TO_IMAGE)
        print "Flattening but not scaling"
    else:
        copyimg = img
        print "Not scaling or flattening"

    # gimp-file-save insists on being passed a valid layer,
    # even if saving to a multilayer format such as XCF. Go figure.

    # I don't get it. What's the rule for whether gimp_file_save
    # will prompt for jpg parameters? Saving back to an existing
    # file doesn't seem to help.
    # run_mode=RUN_WITH_LAST_VALS is supposed to prevent prompting,
    # but actually seems to do nothing. Copying the -save-options
    # parasites is more effective.
    try:
        pdb.gimp_file_save(copyimg, copyimg.active_layer, copyname, copyname,
                           run_mode=RUN_WITH_LAST_VALS)
    except RuntimeError, e:
        gimp.delete(copyimg)
        print "Runtime error -- didn't save"
        return "Runtime error -- didn't save"

    # Find any image type settings parasites (e.g. jpeg settings)
    # that got set during save, so we'll be able to use them
    # next time.
    def copy_settings_parasites(fromimg, toimg):
        for pname in fromimg.parasite_list():
            if pname[-9:] == '-settings' or pname[-13:] == '-save-options':
                para = fromimg.parasite_find(pname)
                if para:
                    toimg.attach_new_parasite(pname, para.flags, para.data)

    # Copy any settings parasites we may have saved from previous runs:
    copy_settings_parasites(copyimg, img)

    gimp.delete(copyimg)
    #gimp.Display(copyimg)
    return None

def init_from_parasite(img):
    '''Returns copyname, percent, width, height.'''
    para = img.parasite_find('export-copy')
    if para:
        #copyname, percent, width, height = \
        paravals = \
            map(lambda x: 0 if x == 'None' or x == '' else x,
                para.data.split('\n'))
        copyname = paravals[0]
        percent = float(paravals[1])
        width = int(paravals[2])
        height = int(paravals[3])
        print "Read parasite values", copyname, percent, width, height
        return copyname, percent, width, height
    else:
        return None, 100.0, img.width, img.height

def python_fu_saver(img, drawable):
    # Figure out whether this image already has filenames chosen;
    # if so, just save and export;
    # if not, call python_fu_saver_as(img, drawable).

    # Figure out whether there's an export parasite
    # so we can pass width and height to save_both.
    copyname, export_percent, export_width, export_height = \
        init_from_parasite(img)

    if img.filename:
        save_both(img, drawable, img.filename, copyname,
                export_width, export_height)
    else:
        # If we don't have a filename, either from the current session
        # or saved as a parasite, then we'd better prompt for one.
        python_fu_saver_as(img, drawable)

def python_fu_saver_as(img, drawable):
    global percent_e, width_e, height_e, orig_width, orig_height, warning_label
    orig_filename = img.filename

    orig_width = img.width
    orig_height = img.height

    # Do we already have defaults?
    copyname, export_percent, export_width, export_height = \
        init_from_parasite(img)

    chooser = gtk.FileChooserDialog(title=None,
                                    action=gtk.FILE_CHOOSER_ACTION_SAVE,
                                    buttons=(gtk.STOCK_CANCEL,
                                             gtk.RESPONSE_CANCEL,
                                             gtk.STOCK_SAVE,
                                             gtk.RESPONSE_OK))

    # Set a current folder, since otherwise it'll be empty
    # and will nag the user to set one.
    if img.filename:
        chooser.set_current_name(os.path.basename(img.filename))
        chooser.set_current_folder(os.path.dirname(img.filename))
    else:
        # No directory set yet. So pick a likely directory
        # that's used by a lot of images currently open.
        counts = collections.Counter()
        for i in gimp.image_list() :
            if i.filename :
                counts[os.path.dirname(i.filename)] += 1
        try :
            common = counts.most_common(1)[0][0]
            chooser.set_current_folder(common)
        except :
            # GIMP has no images open with pathnames associated.
            # So we can't guess at a directory; just leave it blank.
            pass

    copybox = gtk.Table(rows=3, columns=7)

    l = gtk.Label("Export a copy to:")
    l.set_alignment(1.0, 0.5)        # Right align
    copybox.attach(l, 0, 1, 0, 1,
                   xpadding=5, ypadding=5)

    copyname_e = gtk.Entry()
    if copyname:
        copyname_e.set_text(copyname)
    copybox.attach(copyname_e, 1, 7, 0, 1,
                   xpadding=5, ypadding=5)

    l = gtk.Label("Scale the copy:")
    l.set_alignment(1.0, 0.5)
    copybox.attach(l, 0, 1, 1, 2,
                   xpadding=5, ypadding=5)

    l = gtk.Label("Percent:")
    l.set_alignment(1.0, 0.5)
    copybox.attach(l, 1, 2, 1, 2,
                   xpadding=5, ypadding=5)

    adj = gtk.Adjustment(int(export_percent), 1, 10000, 1, 10, 0)
    percent_e = gtk.SpinButton(adj, 0, 0)
    percent_e.connect("changed", entry_changed, 'p');
    copybox.attach(percent_e, 2, 3, 1, 2,
                   xpadding=5, ypadding=5)

    l = gtk.Label("Width:")
    l.set_alignment(1.0, 0.5)
    copybox.attach(l, 3, 4, 1, 2,
                   xpadding=5, ypadding=5)

    adj = gtk.Adjustment(int(export_width), 1, 10000, 1, 10, 0)
    width_e = gtk.SpinButton(adj, 0, 0)
    width_e.connect("changed", entry_changed, 'w');
    copybox.attach(width_e, 4, 5, 1, 2,
                   xpadding=5, ypadding=5)

    l = gtk.Label("Height:")
    l.set_alignment(1.0, 0.5)
    copybox.attach(l, 5, 6, 1, 2,
                   xpadding=5, ypadding=5)

    adj = gtk.Adjustment(int(export_height), 1, 10000, 1, 10, 0)
    height_e = gtk.SpinButton(adj, 0, 0)
    height_e.connect("changed", entry_changed, 'h');
    copybox.attach(height_e, 6, 7, 1, 2,
                   xpadding=5, ypadding=5)

    warning_label = gtk.Label("")
    copybox.attach(warning_label, 0, 7, 2, 3,
                   xpadding=5, ypadding=5)

    copybox.show_all()
    chooser.set_extra_widget(copybox)

    # Oh, cool, we could have shortcuts to image folders,
    # and maybe remove the stupid fstab shortcuts GTK adds for us.
        #chooser.add_shortcut_folder(folder)
        #chooser.remove_shortcut_folder(folder)

    # Loop to catch errors/warnings:
    while True:
        response = chooser.run()
        if response != gtk.RESPONSE_OK:
            chooser.destroy()
            return

        try:
            percent = float(percent_e.get_text())
        except ValueError:
            percent = None
        try:
            width = int(width_e.get_text())
        except ValueError:
            width = None
        try:
            height = int(height_e.get_text())
        except ValueError:
            height = None

        filename = chooser.get_filename()
        copyname = copyname_e.get_text()

        if copyname == orig_filename:
            warning_label.set_text("Change the name or the directory -- don't overwrite original file!")
            continue

        # Whew, it's not the original filename, so now we can save.
        dpy = chooser.get_display()
        chooser.hide()
        dpy.sync()

        err = save_both(img, drawable, filename, copyname, width, height)
        if err:
            markup = '<span foreground="red" size="larger" weight=\"bold">'
            markup_end = '</span>'
            warning_label.set_markup(markup + "Didn't save to " + filename
                                     + ":" + str(e) + markup_end)
            warning_label.set_text(err)
            print "Error:", err
            chooser.show()
            continue
        else:
            pdb.gimp_image_clean_all(img)

        # Otherwise, save_both was happy so we can continue.
        chooser.destroy()

        #gimp.context_pop()

        return

# Doesn't work to compare entry against percent_e, etc.
# Must pass that info in a separate arg, darnit.
def entry_changed(entry, which):
    global percent_e, width_e, height_e, orig_width, orig_height, busy
    if busy:
        return

    # Can't use get_value() or get_value_as_int() because they
    # don't work before an update(), but update() will usually
    # overwrite what the user typed. So define a function:
    def get_num_value(spinbox):
        s = spinbox.get_text()
        if not s:
            return 0

        try:
            p = int(s)
            return p
        except ValueError:
            try:
                p = float(s)
                return p
            except ValueError:
                return 0

    if which == 'p':
        p = get_num_value(percent_e)
        if not p: return
        busy = True
        w = int(orig_width * p / 100.)
        width_e.set_text(str(w))
        h = int(orig_height * p / 100.)
        height_e.set_text(str(h))
        busy = False

    elif which == 'w':
        w = get_num_value(width_e)
        if not w: return
        busy = True
        p = w * 100. / orig_width
        percent_e.set_text(str(p))
        h = int(orig_height * p / 100.)
        height_e.set_text(str(h))
        busy = False

    elif which == 'h':
        h = get_num_value(height_e)
        if not h: return
        busy = True
        p = h * 100. / orig_height
        percent_e.set_text(str(p))
        w = int(orig_width * p / 100.)
        width_e.set_text(str(w))
        busy = False
    else:
        print "I'm confused -- not width, height or percentage"

register(
    "python_fu_saver",
    "Save or export the current image, optionally also exporting a scaled version, prompting for filename only if needed.",
    "Save or export the current image, optionally also exporting a scaled version, prompting for filename only if needed.",
    "Akkana Peck",
    "Akkana Peck",
    "2014",
    "Saver",
    "*",
    [
        (PF_IMAGE, "image", "Input image", None),
        (PF_DRAWABLE, "drawable", "Input drawable", None),
    ],
    [],
    python_fu_saver,
    menu = "<Image>/File/Save/"
)

register(
    "python_fu_saver_as",
    "Prompt to save or export the current image, optionally also exporting a scaled version.",
    "Prompt to save or export the current image, optionally also exporting a scaled version.",
    "Akkana Peck",
    "Akkana Peck",
    "2014",
    "Saver as...",
    "*",
    [
        (PF_IMAGE, "image", "Input image", None),
        (PF_DRAWABLE, "drawable", "Input drawable", None),
    ],
    [],
    python_fu_saver_as,
    menu = "<Image>/File/Save/"
)

main()

