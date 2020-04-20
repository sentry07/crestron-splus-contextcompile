# crestron-splus-contextcompile
Cmd file that enables compiling SIMPL+ USP/CSP files from Windows Explorer

This is done by editing the Windows registry. Don't try this at home, I'm a professional and these
files will do it for you.

Right click the USP_EnableContextCompile_RunAsAdmin.cmd file and select Run as Administrator and
it will update the context menu for all USP files to have more options, specifically:
* Compile 2 Series
* Compile 2 + 3 Series
* Compile 3 Series
* Compile 3 + 4 Series
* Compile 4 Series

If, after running this script, you do NOT have those options available, it is probably because
you were like me and got tired of double clicking USP files only to have SIMPL Windows open so
you set the file association manually. If this is the case, no problem. Double click the file
called CleanOpenWithSettings and then click Yes to fix the issue.

If you wish to remove the items from the context menu, double click the RemoveContextItems file
and then click Yes to remove the files.


# Files:
* USP_EnableContextCompile_RunAsAdmin.cmd : The main file that does the cool stuff
* RemoveContextItems.reg : The registry file to remove context items
* CleanOpenWithSettings.reg : The registry file that removes old file associations
