# Library Modifications

## Table of Contents

1. [Necessary Information](#some-information)
2. [Quick Modifications](#quick-modifications)
    - [Video Support](#video-support)
    - [Replacing Backgrounds](#replacing-the-backgrounds)
    - [Center the Titles](#center-titles)
    - [Wide Mode Consistency](#wide-mode-consistency-in-the-collections-page)
    - [Extra Collections](#extra-collections)

## Some Information

You may want to refer to the QML documentation for common types. QML has many different types, whose properties are thoroughly documented. Common QML types [can be found here](https://doc.qt.io/qt-5/qtquick-qmlmodule.html)

## Quick Modifications

Here are some quick modifications you can do on Library. These don't teach you much, but they add functionality that isn't included by default or in the settings.

### Video Support

Adding video support is relatively simple. This guide will do the modification on the normal gameitem, which covers most instances where games are shown. This may also be applied to the widehead gameitem, though this won't be covered.

Firstly, you will want to go to GINormal.qml, located under GameItems in the theme folder. Then, scroll down to the `Image` with the id `gameItemImage`. Just above this, add a video with the following code, which creates a Video object that behaves identically to the image while only showing if there is a video:

```
Video {
    id: gameItemVideo
    width: parent.width
    height: parent.height

    visible: currentGame.assets.video

    z: gameItemText.z + 1

    anchors.centerIn: parent
    fillMode: Image.PreserveAspectCrop

    source: currentGame.assets.video
}
```

You will then want to add the following line in `gameItemImage`, which hides the image if a video is present. This line can be placed anywhere in `gameItemImage`.

```
Image {
    id: gameItemImage
    ...

    visible: !(currentGame.assets.video)

    ...
}
```

This is all that's necessary to add video functionality to most parts of the theme. You may want to do the same for GIWidehead.qml if you want this functionality in the home screen's recent games list.
<br><br>

### Replacing the Backgrounds

Replacing the backgrounds involves either replacing the images or replacing the plain color. Each will be covered below:

- Image Replacement<br>
To replace the background images, simply copy the background images to the theme folder and rename them to background-dark and background-light. Make sure that both images exist, and that they have the .jpg extension.

- Color Replacement<br>
To replace the plain background color, open theme.qml, and find the Rectangle object with the id `backgroundPlain` (you may ctrl+f for this). You will see a line defining the property `color`, which looks like the code block below this. Change #FFFFFF to the light mode color, and #121212 to the dark mode color, each in hex format.
```
color: light ? "#FFFFFF" : "#121212"
```
<br>

### Center Titles

To center game titles, it is incredibly easy. The functionality is already there, though it is disabled by default.

Go into theme.qml, and find the variable `centerTitles` (it should be under all the settings). Then, you would simply change it to true like so:

```
property bool centerTitles: true
```

### Wide Mode Consistency In the Collections Page

By default, wide mode does not affect the collections page collections. This is because there are only portrait-style icons for each collection. A simple modification, however, can easily allow you to change this.

To perform this modification, go to `[THEME_FOLDER]/Theme/Collections.qml`. Then, under the GridView `collectionsView`, modify the following line.

```
GridView {
    id: collectionsView
    ...

    cellWidth: wide ? (width / 2) : (width / 6)

    ...
}
```

This is all that is needed to make the Collections page top menu become wide in wide mode. One could get wide images if they wish, but to implement these, it would take a bit more effort in GICusart.qml, which I will not cover here.
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


## Final Notes

If you would like to know more, you may want to look through the comments of this theme's files to find out how exactly things work. These comments tell what each function does. If you would really like to know more, I encourage you to try to build your own theme, learning the ins and outs of theming and QML. By learning to build your own theme, referencing other themes, searched snippets and other resources, you will learn how to theme, and you will get a full understanding of QML theming. Indeed, I made themes that looked and worked horribly compared to this one in the past, but after spending time learning, I have made this theme which I am proud of.

The skills you can learn with QML are not limited to Pegasus, but can be used in any QtQuick environment, notably most of the stuff made by [KDE](https://kde.org/). I heavily encourage you to take the plunge and learn how to make your own QML theme, or just find ways to absolutely butcher this one. I don't care, you should be able to mess with this theme however.
