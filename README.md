Backup
======

About
-----

Backup is a shell script which tries to simplify/speed up the process of making
backups. The paths that need to be backed up are read from a file containing
the full pathnames to the paths or files that need to be backed up.
Optionally, a script can be listed which can perform an arbitrary task and
write its output to a designated directory which will be backed up. A tar.bz2
archive is created for each directory.

Configuration is provided through a local or global configuration file. 

Installation
------------

Installation is currently not automated, so you will have to install it by
hand. Here are some quick steps for installation:

*   Edit backup.conf
*   Edit backup.list
*   Copy backup.conf to /etc/ or a local directory from which you will 
    run backup.
*   Copy backup.list to the directory defined in backup.list (see 
    BACKUP.CONF section)
*   Copy the backup executable to i.e /usr/local/sbin
*   Change permissions on all files if needed.

Here's a more in-depth explanation of the configuration files:


### backup.conf

The backup.conf file contains the configuration for Backup. When Backup is ran,
it first checks the current directory for the file. If it is found it will be
parsed. If it isn't found, backup will look for the file in the /etc/
directory, and parse it. If still no configuration file was found, then the
script will abort. 

A custom location can be specified using the `-c` parameter. This can be used
to perform different backups per day, week or month.

Configuration values are in the form of: `CONFIGOPTION=value`

The configuration options (`CONFIGOPTION`) are *case sensitive*!

Check the backup.conf example file for a list of directives which are accepted.

### Backup.list

The backup.list contains the various backup directives which specify everything
that should be backed up. The syntax for a backup directive is:

    TYPE:LOCATION

The `TYPE` can be one of the following:

    D     Normal directory.
          This will backup the given directory in a single archive.
          LOCATION should point to a path.

    I     Include.
          This will take the output of the given script and treat it as
          normal backup directives. LOCATION should point to an exexutable
          script. The script takes no parameters.

    C     Custom.
          A custom script which will do all the backup work itself.
          LOCATION should point to an executable script. The script should
          take one parameter which will be the directory where the backups
          are to be placed. No PRE_EACH and POST_EACH is run on the
          generated backups.

    S     Script.
          A normal script which will put the files that need to be backed
          up into a directory which will then be backed up to a single
          archive. LOCATION should point to an executable script. The
          script should take one parameter which will be the directory
          where the files are to be placed.

Look in the contrib and examples directory for Include, Custom and Script
examples.

The `LOCATION` is the location to a file, directory or executable script
(depending on the type of the directive).

You'll find some examples in the backup.conf.

Each directive, except for the Custom directive, will result in a single
tar.bz2 file in the `DEST_DIR` directory. Custom scripts should place the
resulting archives it creates in the `DEST_DIR` directory itself.

### Automation.

If you want backup to run automatically, say, every week you can create the
following entry in your /etc/crontab:

    00 3    * * 1   root    /usr/local/sbin/backup

This will generate some output each time it's finished backing up.  Depending
on your configuration, this output will automatically be mailed to you. If you
do not wish backup to generate this output, just add a redirector to the
crontab like this:

    00 3    * * 1   root    /usr/local/sbin/backup > /dev/null

Or redirect the output to some kind of backup log. Errors during the backup
will still be mailed to you (depending on your configuration)

If you cannot run backup as root, you can add the following line to your
personal crontab:

    00 3    * * 1   /home/john/bin/backup > /dev/null


Depending on your Operating System and your personal needs/rights, you may be
able to place a script in /etc/cron.daily or /etc/cron.weekly which will run
the backups.

### Pre and Post scripts

Four kind of scripts can be configured in the configuration file:

`PRE`

    Ran before creating the target path and starting the backup. This script can be
    used to, for instance, mount a HD or rewind tapes.  A numder of variables are
    exported to this script:
        
    DEST_DIR     : The destination directory which will contain the 
                   individual backups. /path/to/dest/
    
`PRE_EACH`

    Ran before each individual path backup. Exported variables:

    SOURCE_DIR   : Source directory for the backup. /var/lib/mysql/
    DEST_DIR     : See above. /path/to/dest/
    DEST_FILE    : filename for the new backup. var.lib.mysq.tar.bz2

`POST_EACH`

    Ran after each individual path backup. See PRE_EACH

`POST`

    Ran after the backup is done. See PRE


Copyright and License
---------------------

Copyright (c) 2000-2013, Ferry Boender <ferry . boender at electricmonk .nl>

Licensed under the General Public License (GPL)

This program is free software; you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation; either version 2 of the License, or (at your option) any later
version.
    
This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE. See the GNU General Public License for more details.
    
You should have received a copy of the GNU General Public License along with
this program; if not, write to the Free Software Foundation, Inc., 675 Mass
Ave, Cambridge, MA 02139, USA.
            
For more information, see the COPYING file supplied with this program.
