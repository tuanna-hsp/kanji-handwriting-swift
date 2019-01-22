## Integrate Zinnia to an existing project

#### 1. Download the [ZinnaCocoaTouch](https://github.com/shinjukunian/iOS-Zinnia-Japanese-Handwriting-Input) library.
and put it somewhere in your working directory.
![](https://raw.githubusercontent.com/tuanna-hsp/file-hosting/master/Repo/kanji-handwriting-swift/1.jpeg)


Add the library to your project from XCode.

![](https://raw.githubusercontent.com/tuanna-hsp/file-hosting/master/Repo/kanji-handwriting-swift/2.jpeg)

![](https://raw.githubusercontent.com/tuanna-hsp/file-hosting/master/Repo/kanji-handwriting-swift/3.jpeg)


If you see the library files appear in XCode like this then it's great.

![](https://raw.githubusercontent.com/tuanna-hsp/file-hosting/master/Repo/kanji-handwriting-swift/4.jpeg)


#### 2. Configure your project.
Open your **Project settings** → **Build phases**. In the **Target Dependencies**, add `ZinniaCocoaTouch`

![](https://raw.githubusercontent.com/tuanna-hsp/file-hosting/master/Repo/kanji-handwriting-swift/5.jpeg)


Next, in the **Link Binary With Libraries**, add `ZinniaCocoaTouch.framework`

![](https://raw.githubusercontent.com/tuanna-hsp/file-hosting/master/Repo/kanji-handwriting-swift/6.jpeg)


To make the provided model (`ZinniaCocoaTouch/Supporting Files/handwriting.model`) bundled with the build, add a Copy Files Phases

![](https://raw.githubusercontent.com/tuanna-hsp/file-hosting/master/Repo/kanji-handwriting-swift/7.jpeg)
![](https://raw.githubusercontent.com/tuanna-hsp/file-hosting/master/Repo/kanji-handwriting-swift/8.jpeg).


#### 3. Create an Objective-C bridging header to import the library classes to your Swift files.

![](https://raw.githubusercontent.com/tuanna-hsp/file-hosting/master/Repo/kanji-handwriting-swift/9.jpeg)


If your project doesn't compile, check the **Build Settings** for whether the header has been properly configured.

![](https://raw.githubusercontent.com/tuanna-hsp/file-hosting/master/Repo/kanji-handwriting-swift/10.jpeg)

**That's it! You have successfully integrated Zinnia to your project. Happy coding!**
