# iOS-Zinnia-Japanese-Handwriting-Input
Handwriting recognition for Japanese Kanji / Kana in iOS as an Objective-C framework (requires iOS8).
Compared to static libraries, frameworks allow the inclusion of header files and, most importantly, assets.

For app extensions, frameworks can be shared with the main application.

To use, simply include as a git submodule, add as an embedded binary and add
``` 
@import ZinniaCocoaTouch;
``` 
to your files.

A sample project includeing a keyboard extension can be found at https://github.com/shinjukunian/KanjiLookup.

#Acknowledgements
Zinnia (http://zinnia.sourceforge.net)
The handwriting model uses data from Tomoe-Tegaki (http://tomoe.sourceforge.jp/cgi-bin/en/blog/index.rb) and KanjiVG (http://kanjivg.tagaini.net) using scripts by Roger Braun https://github.com/rogerbraun/KVG-Tools
