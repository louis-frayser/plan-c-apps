# Plan C Apps(Src dir is PlanC or Lucho)
This project houses open-source (BSD licensed) music-related applications, created using the [LambdaNative](http://www.lambdanative.org) cross-platform development environment.

## Applications
* [PlanC](apps/PlanC): An application for recording details of music practice
* [Reeds](apps/Reeds): A inventory for tracking clarinet reeds.
* [Repertoire](apps/Repertoire): Managing songs in ones repertoire.


## History
Plan C is derived by a web-based Racket (scheme) app of the same name.
The original app in on [GitHub](https://github.com/louis-frayser/plan-c.git)

## Install
*** Fonts
I copied the Bahaus fonts t ~/lambdanative/fonts/Bahaus and never tried using them from the local fonts dir.

*** Building
[1] "./make_antroid" to configure and build for Android. The output is placed in ~/release/PlanC. The script signs the .apk as the framework tools are too out of date.

[2] For the Linux build, I run ./clg.sh which build the app and places it in ~/apps/PlanC, then launches it.
.

*** Caveats
There is a tool dx that I had to copy from an older version of the sdk.  D8 is what the new tool is called, but the framework currently want's the missing dx.
