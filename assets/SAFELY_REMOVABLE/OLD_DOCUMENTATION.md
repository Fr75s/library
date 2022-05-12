# Warning

This is old documentation that was the original intent for this theme's documentation. I have decided instead to make this into just comments.



## In Depth Editing Information

This section will detail this theme fully, in order to allow you to have a greater understanding of this theme as well as QML. This will serve well for those who wish to perform heavy modifications of this theme or fork this theme. It is highly recommended that you take a look at the following sources at times while you look at this information:

- [QtQuick QML Types](https://doc.qt.io/qt-5/qtquick-qmlmodule.html) (note that a quick search for the type followed by 'QML' will yield information for that type; not all types are here)
- [Pegasus Frontend Theme API](https://pegasus-frontend.org/docs/themes/api/)

### theme.qml

`theme.qml` can be divided into several parts. We first import all necessary QML modules, going from `QtQuick 2.8` to `SortFilterProxyModel 0.2`. Afterwards, we import other parts of the theme. To read more about these parts, see [Theme Folder Pages](#theme-folder-pages) and [Game Items](#game-items).

The next few sections are described below.
<br><br>

#### Variables

The first portion under the `FocusScope` is where we define all variables. A list of each is below.

- `focus`: Set the FocusScope to be focused, so that it receives input.
- `sw`, `sh`: Define quick screen width and height references, used instead of parent.width and parent.height in top-level items
- `menu`: Sets the current menu page. This is used to create the home, search, collections and settings pages. See [Pages](#pages).
- `focused`, `gameView`: Defines page behaviors in the home and collections pages respectively, defined here to not be affected in their respective pages.
- FontLoaders: These `FontLoaders` simply define fonts for use throughout the theme.

- `iconSize`, `marginAnimVel`, `giShadowRad`, `giShadowOp`: These values set several miscellaneous properties for several different parts where these properties would otherwise need to be defined in several places.
    - `iconSize` defines the size of the icons in the bottom bar.
    - `marginAnimVel` defines the speed in which the expansion/contraction animation for highlighting games.
    - `giShadowRad` defines the size of game box shadows.
    - `giShadowOp` defines the opacity of the same game box shadows as above.

- Settings: The last variables defined are settings which correspond to those in the settings page.
    - `light`: Light Mode
    - `plainBG`: Plain (Flat) Background
    - `noBtns`: Removes button indicators
    - `sbsl`: Shows clock bar (originally restricted search functionality)
    - `nosfx`: Mutes all sound effects
    - `wide`: Wide game view
    - `quiet`: Quiets sound effects (halves volume)
    - `moreRecent`: Increases the number of games under Recent Games
    - `mouseNav`: Enables mouse navigation arrows
    - `enlargeBar`: Enlarges the bottom bar
    - `limSearch`: Limits search results to those which start with the search rather than contain the search
<br><br>

#### bottomBar

After defining the variables, we go on to define the bottom bar. This is used to indicate which page we are currently on. This `bottomBar` Item contains a row of images, a background rectangle and a MouseArea.

For each image in this row, we get its image from `[THEME_FOLDER]/assets/theme/[image].svg`, as well as allowing for clicks on the icons to switch to the respective page. You can easily modify the icon sizes with the `iconSize` setting from [Variables](#variables), as well as changing the source of the icons.

`bottomBar` also contains a background rectangle, which simply overlays over the rest of the content. Its color is changeable here.

The MouseArea here is to block clicks that occur on the bar, preventing one from accidentally clicking an item under the bar when not intended.

Finally, outside of the `bottomBar` itself are 2 other items. One is the indicator rectangle for the bar, which shows the icon currently selected. It takes a small shortcut with its width, using the home icon to set its width. Its x position is defined by an equation, which simply does the following:
1. Moves the indicator to the screen's center
2. Move the indicator left to the home icon, by moving it left 2 icons and 1.5 spaces between the icons (the .5 comes from the fact that there are an even number of icons, so the .5 places it on the icon just left of the center)
3. Moves it right one space and one icon multiplied by the current menu value (this is why menu is an integer: it allows the indicator to properly move right)
The y position of the indicator rectangle is simply placed respective to the screen height. Finally, a behavior is defined, which animates the indicator's movement.

The other item outside of the `bottomBar` is the BottomBarIcons item, the first of several items defined outside of the theme.qml file. BottomBarIcons.qml is located under `[THEME_FOLDER]/Bottombar`, and defines the controller icons for the bottom bar. These are simply QML rectangles which are placed on 2 rows, each varying in several properties.

One potential idea for a modification to `bottomBar` is to change its position, which could be done by anchoring it to another side, changing the height and width, and converting the Row `bbImages` to a Column.<br><br>


#### Pages

After defining the bottomBar, we move on to pages, which are the objects from Colcon to ClockBar. These contain the main functionality of the theme, but in theme.qml, their definitions here only serve to put them on the theme itself.

In-depth information on each page is under [Theme Folder Pages](#theme-folder-pages).

`Colcon` defines a simple converter for Launchbox shortnames, as Launchbox has several shortnames which do not match up with those of the logos in `[THEME_FOLDER]/assets/logos/banner/`. This was **stolen** :(.

Next we have the `Home`, `All`, `Collections`, and `Settings` pages. These are the main pages that show up. Each one fills the screen, and has a focus which corresponds to the `menu` variable, also setting the visibility. To change which page is visible, we modify `menu`; see [Other Functionalities](#other-functionalities) for more information.

Finally, we have the `ClockBar`, which is made visible through the `sbsl` variable and placed above the other parts of the theme.
<br><br>

#### Other Visuals

The last visual portions of theme.qml define the background of the theme. First is the background image (`backgroundImage`), which is the actual image of the background, placed under all other parts of the theme. To add some visual effects, we add a ShaderEffectSource and GaussianBlur applied over the image to add a blur effect. If either background image isn't present or `plainBG` is true, we show the plain background, which is simply a rectangle that fills the screen, placed over `backgroundImage`.

#### Other Functionalities

The end of theme.qml defines some non-visual functions. It starts by defining several sound effects, located in `[THEME_FOLDER]/assets/audio/`, which are used in numerous places in the theme.

After the sound effects, we define the menu changing behavior. With the input of the nextPage and previousPage buttons (LB/L1 and RB/R1), we change the current page of the theme. These functions also allow the navigation to wrap around.

Finally, we define a `launchGame()` function, which launches games. This is where we reach the end of theme.qml.
<br><br>

### Theme Folder Pages

The following section goes through the files in the `[THEME_FOLDER]/Theme` directory. There are 6 files in this folder, which will be covered in the next sections.

#### Home.qml

Home.qml defines the home page of the theme, which shows the recent games and favorite games sections. Home.qml starts by defining a few variables and other items.

- `maxRecents` defines the maximum number of games in the recent games list.
- `sort_last_played_base`, `recent` and `favorites` define models for the recent and favorite games lists. `sort_last_played_base` defines a model with the last played games, and `recent` restricts that model to `maxRecents` items. `favorites` defines a model listing all favorited games, which are defined by pegasus.
- `currentGame` defines the currently highlighted game. The block of code here sets the game to be the currently selected game in the currently selected list (recent or favorites), allowing for launching the game to work properly.
- `uiY`, similar to `currentGame`, is defined by code. The code here changes this value whether or not the recent games or the favorite games are selected, changing the vertical position of the UI to scroll the page to the favorite games.
- `animVel` defines the animation speed of the animation that plays on scroll.
<br>

After we define these variables, we create 3 simple objects, 2 of which just define text to indicate each section, and the other creates a clickable arrow which scrolls the page back up. While the Text objects are relatively simple, with the only thing of note being the y position, the up arrow is different, as it has a MouseArea which scrolls the view back up, allowing for mouse-based navigation. This is disabled if `mouseNav` is false.

We then have a ListView, which shows our recent games. While there is lots of stuff here, the only thing of note is the `doubleFocus` property of the delegate Item, which highlights the item if the ListView and itself is focused. As well, the GINormal Item has the `wideHead` property set to true, making its first item wider.




### Game Items

### Other Parts

