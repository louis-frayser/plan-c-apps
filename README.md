# Plan C Apps
This project houses open-source (BSD licensed) music-practice-related applications,
Created using the [LambdaNative](http://www.lambdanative.org) cross-platform development environment.

## Applications
* [PlanC](apps/PlanC): An application for recording details of music practice
* [Reeds](apps/Reeds): A inventory for tracking clarinet reeds.
* [Repertoire](apps/Repertoire): Managing songs in ones repertoire.

## History
Plan C is derived from a web-based Racket (scheme) app of the same name.
The original app is on [GitHub](https://github.com/louis-frayser/plan-c.git)

## Install
The sources should be extacted to a directory names PlanC or Lucho

### Fonts
I copied the Bahaus fonts to ~/lambdanative/fonts/Bahaus and never tried using them from the local fonts dir.

### Building
[1] "./make_anroid" to configure and build for Android. The output is placed in ~/release/PlanC. The script signs the .apk as the framework tools are too out of date.

[2] For the Linux build, I run ./clg.sh which build the app and places it in ~/apps/PlanC, then launches it.
.

### Caveats
1. There is a tool dx that I had to copy from an older version of the sdk.  D8 is what the new tool is called, but the framework currently want's the missing dx.
2. Fonts can be local in ${PlanC}/fonts of then can be placed in ../lambdanative/fonts to be shared with all projects.
   If a font is in both places there will be a message about the onts in lambdanative shaddowin the local font in PlanC.
3.  On the 1st two font line in apps/${App}/FONTS are used.
    The format is <relative font.path> a 7,8 or a set name  a list of sizes (14,18,24 etc) then an alias.
    See main.scm to see how the fonts are used.  This app uses Bahaus of most things and somethin close to monspaced for list
    widgets. It avoids cmss becaue it doesn't display then symbols <,> correctly.
