# **Space Shooter**
_Control Your Ship, Avoid Meteors, and Collect Power-Ups._

## **Table of Contents**
- [Overview](#overview)
- [Getting Started](#getting-started)
- [Gameplay](#gameplay)

## **Overview**
_Initially a Tutorial Project, it has currently been fleshed out to be a playable game on Windows and Android._

Created with the [Godot 4 Crash Course Tutorial Series](https://www.youtube.com/watch?v=q7wlSvt0JIc&list=PL4cUxeGkcC9iHCXBpxbdsOByZ55Ez4bgF&pp=iAQB), I took the end result, added power-ups, a few quality of-life improvements, and created additional functionality so that it could function on Android. What issues currently do exist (Android UI doesn't quite scale to my satisfaction, etc.), I do not currently have the required knowledge or expertise to fix, thus that way it will remain.

## **Getting Started**
_A step-by-step guide on how to get the project up and running. Disclaimer: As someone who has never built something from another repo before, I am clueless. Just so you know. Here is my approximate help, though._

### Prerequisites:
_Before you begin, ensure you have the following installed:_

* Godot Engine: Download the latest version [here](https://godotengine.org/).
* Git: For cloning the repository. Get it [here](https://git-scm.com/).
* Android Build Support (if building for Android):
*     Android SDK
*     Android NDK
*     OpenJDK

### To Export/Build:
_Export Presets are included, so most of the settings should be fine. Be sure to change the export destination, however._

1. **_Clone the repository:_**
    ```git
    git clone https://github.com/sarahyack/Space-Shooter.git
    ```
2. **_Open the Project in Godot:_**
    Open Project manager, select **Import** and choose the location of your cloned project and open the 'project.godot' file. The project should now be in the projects list, so select **Edit** to open it.
    Should you wish to run the project, this can be done using the Play button in the top right or can be done from the project manager, simply select the **Run** option instead of **Edit**.

3. **_Export:_**
    Go to **Project -> Export** and select what you want to build to. Please note that export presets are only provided for the following setup (**Windows -> Android**) as preset 0 corresponds to the Windows setup, and preset 1 corresponds to the Android setup (unless I have misunderstood it, which it is entirely likely that I have). Click **Export Project or Export all** and choose a destination folder to export to.
    Exporting the SDK for Android is the same process.

All assets and dependencies are included in the repo, so from here you should be golden!

**This Project was made with:**
*     Godot 4.2 / Godot 4.3
*     Kenney's Space Shooter Redux Asset Pack
*     Kenney's On-Screen Controls Pack

## **Gameplay**
_The Level of Simple is Astonishing._

An Arcade Game where you must survive, shoot meteors, and collect power-ups to increase your score.

Control your Ship with W, A, S, D or the onscreen controls (Android), avoid the meteors and shoot with either left-click or the big shoot button. There is limited joystick support at the moment, as the joystick works with the core game and the end splash screen, but the main menu isn't compatible. Currently, I have no plans to add the needed support.

Avoid meteors to preserve your 5 lives, and collect power-ups to give yourself boosts.

There are 5 Power-Ups:
*     Health
*     Weapon Boost
*     Shield
*     Fire Wave
*     Call for Help

Hope you have fun, and thank you for checking out my game!