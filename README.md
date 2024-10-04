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
I copied the Bahaus fonts t ~/lambdanative/fonts/Bahaus and never tried using them from the local fonts dir.
".Configure PlanC android" to build for Android. The output is placed in ~/release/PlanC. Where I run aa script called sign_apk, because the standard tools are a little out of date.

For the Linux build, I run ./clg which build the app and places it in ~/apps/PlanC, then launches it.
.
