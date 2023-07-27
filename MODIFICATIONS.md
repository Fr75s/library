# Library Modifications

## Table of Contents

1. [Necessary Information](#some-information)
2. [Quick Modifications](#quick-modifications)
    - [Adding/Replacing Backgrounds (Updated for 1.4.0)](#replacing-the-backgrounds)
    - [Custom Color Schemes (1.2.0+)](#custom-color-schemes)
    - [Extra Collections](#extra-collections)
3. [Translation](#translation)

## Some Information

You may want to refer to the QML documentation for common types. QML has many different types, whose properties are thoroughly documented. Common QML types [can be found here](https://doc.qt.io/qt-5/qtquick-qmlmodule.html)

## Quick Modifications

Here are some quick modifications you can do on Library. These don't teach you much, but they add functionality that isn't included by default or in the settings.

### Replacing the Backgrounds

You can easily add/change the backgrounds shown in Library.

To do this, go to `assets/backgrounds` in the theme's root directory (`[LIBRARY FOLDER]/assets/backgrounds`). Then, add your desired backgrounds, but be sure to add one for light mode and one for dark mode. Rename the backgrounds to `light-[number].jpg` and `dark-[number].jpg`, where `[number]` is the next number from the last backgrounds (which would be 3 if no backgrounds have been added, as Library comes with 2 sets of backgrounds.). Now, you can change to your background by finding the "Change Background" option.

You can also set the color of the plain background by setting the color for `plainBG`. To learn more about changing colors, see [Custom Color Schemes](#custom-color-schemes).

### Center Titles

To center game titles, it is incredibly easy. The functionality is already there, though it is disabled by default.

Go into theme.qml, and find the variable `centerTitles` (it should be under all the settings). Then, you would simply change it to true like so:

```
property bool centerTitles: true
```

This is all that is needed to make the Collections page top menu become wide in wide mode. One could get wide images if they wish, but to implement these, it would take a bit more effort in GICusart.qml, which I will not cover here.
<br><br>

### Custom Color Schemes

Creating custom color schemes for this theme can be done by going into theme.qml and modifying the colorschemes variable.

To do this, first open up theme.qml. You should then navigate to a big object with lots of strings, looking like so:

```
property var colorschemes: {
    "polar": {
        "light": {
            "plainBG": "#F2F6FF",
...
```

This is your color scheme variable, and is where you will define color schemes. I recommend adding something like so:

```
    },
    "mycolorscheme": {
        "light": {
            ...
        },
        "dark": {
            ...
        }
    }
```

After making this, add all the colors in. You can find the names of each color by looking at either the polar or classic color schemes, which are there by default and contain color names like "accent" and "text." Use the same style as the other color schemes, replacing the hex codes or color names with whatever colors you want.

Once you finish your colorscheme, simply replace the line `property var colors: ...` with the following:

```
property var colors: light ? colorschemes["mycolorscheme"]["light"] : colorschemes["mycolorscheme"]["dark"]
```

Now you have a custom color scheme for use with Library.
<br><br>

### Extra Collections

You may see a few extra collections when browsing through the collection images. Here is how to do a few of them.

**Windows Store Games**<br>
Surprisingly enough, Windows store games can be used and run well in Pegasus, better than steam games even. Using the following method, you will be able to run windows store games on Pegasus.

1. Install UWPHook<br>
UWPHook is a tool which enables you to put windows store games on steam, however, it also enables you to launch windows store games using relatively simple commands on the command line. [The link to the project can be found here.](https://briano.dev/UWPHook/)

2. Find out your game's code<br>
Finding out the code of your game is the hardest part. This will require you to go into your AppData folder, which is typically hidden in your user folder. Go to %APPDATA%/Local/Packages, and you will find folders containing the contents of windows store applications, but only the names are needed here. Copy the names of the applications you wish to use: you can typically discern your app from others by looking for the developer's name. Copy the names of the folders containing the apps you would like to launch, and save them for later.

3. Creating blank files<br>
To go around Pegasus's requirement for 1 file per game, we will create several files. In the same place you wish to put your metadata.pegasus.txt, create one blank file for each package name you got in step 2. Rename these to `[PACKAGE_NAME].txt`

4. Creating metadata.pegasus.txt<br>
Once this is done, metadata.pegasus.txt is relatively simple. With a default UWPHook install location:
```
collection: Windows Store
shortname: winuwp
launch: "C:/Program Files (x86)/Briano/UWPHook/UWPHook.exe" "{file.basename}!App"
```

Then, you would define games with:
```
game: [GAME_NAME]
file: ./[PACKAGE_NAME].txt
...
```

This is all that is needed to run windows store games on pegasus.



**Pico-8**<br>
Pico-8 through pegasus frontend is easy and simple to do if you have the desktop application. Once you do so, creating a metadata.pegasus.txt file is easy:

```
collection: Pico-8
shortname: pico8
...
launch: [PATH OF PICO-8 EXECUTABLE] -run {file.path}
...
```

This is good if Pico-8 is installed portably on your system; if not, simply use pico-8 rather than the full path.

**Tic-80**<br>
Tic-80 comes as a libretro core, making it easy to use with retroarch. While retroarch may differ per system, using a metadata.pegasus.txt which links to the tic-80 core would allow you to run tic-80 games in retroarch.


## Translation

Translating this theme is done through the Localization.qml file.

First, open Localization.qml and navigate to the localization property, which should look like so:

```
property var localization: {
    "en": {
        home_recent: "Recent Games",
        home_favorite: "Favorite Games",
        ...
    }
    ...
}
```

Pay attention to the "en" object within localization. This is what you should copy to translate the theme. Create a new object with the same keys as `"en"`, then replace the English strings with those of your desired language. Afterwards, rename the `"en"` copy to the 2 letter code for your language, e.g. `"es"` for Spanish. Your localization object should now look like so (using "es"/Spanish as an example):

```
property var localization: {
    "en": {
        home_recent: "Recent Games",
        home_favorite: "Favorite Games",
        ...
    },
    "es": {
        home_recent: "Juegos Recientes",
        home_favorite: "Juegos Favoritos",
        ...
    }
    ...
}
```

If your object is written properly, you are done, as Library handles the rest when it comes to using your strings and changing languages. To test your localization, change your language to the one you added by going to the Settings page and clicking the "Change Language" option, located at the bottom of the page.

Afterwards, you probably want to add this to the theme officially to let others access your translation. Simply add a pull request to the github page (you can search a tutorial for that online) or message me on Discord (Francisco75s#0331; if you prefer matrix @fr75s:matrix.org), and I will happily add your translation.
