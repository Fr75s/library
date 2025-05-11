# Extra Information for Library

This document contains some extra information regarding some features of Library. It will provide some tips regarding the in-built features of Library, with no code modification necessary. Code modification stuff can be found in `MODIFICATIONS.md`.

## Search Modes (1.5.0+)

There are currently **4** search modes in Library: Regular, Limited, Fuzzy, and Raw.

- Regular: Finds any games which contain the given search anywhere in their title. Not case sensitive.
- Limited: Finds any games which contain the given search at the beginning of their title. Not case sensitive.
- Fuzzy: Finds games using a command prompt shorthand style of searching. Characters are matched in order and do not need to be adjacent to eachother (for example, unlike in Regular/Limited search, "ut" would match "Multiverse"). Capital letters let you enforce word boundaries by forcing the next letter to be at the beginning of a word (e.g. "BB" would match "Bugle Boggle" but not "Bugle Trouble", while "bb" would match both). While the syntax of fuzzy search is case-sensitive, the matching itself isn't (so, for example, "BB" would match both "Bugle Boggle" and "bugle boggle").
- Raw: Finds games by treating the given search as a raw RegEx pattern. You can use any RegEx symbols to match game titles.


## Replacing the Backgrounds (1.4.0+)

You can easily add/change the backgrounds shown in Library.

To do this, go to `assets/backgrounds` in the theme's root directory (`[LIBRARY FOLDER]/assets/backgrounds`). Then, add your desired backgrounds, but be sure to add one for light mode and one for dark mode. Rename the backgrounds to `light-[number].jpg` and `dark-[number].jpg`, where `[number]` is the next number from the last backgrounds (which would be 3 if no backgrounds have been added, as Library comes with 2 sets of backgrounds.). Now, you can change to your background by finding the "Change Background" option.

You can also set the color of the plain background by setting the color for `plainBG`. To learn more about changing colors, see [Custom Color Schemes](#custom-color-schemes).
