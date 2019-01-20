## Kanji handwriting recognition for iOS using Zinnia.

### Overview
[Zinnia](http://taku910.github.io/zinnia/) is a great handwriting regconition library based on SVM. We use it in our [Japanese dictionary app](https://itunes.apple.com/jp/app/suge-dict-tu-dien-nhat-viet/id1446211651) as the Kanji input engine.

This sample project use a customized version of Zinnia, called [ZinnaCocoaTouch](https://github.com/shinjukunian/iOS-Zinnia-Japanese-Handwriting-Input), which already provided the data model and interface implementation in Objective-C.

### If you start anew
Feel free to clone this project and start developing.
It is written in Swift 4 and XCode 10.1.

### Intergrate Zinnia to your existing project
The process is a bit long but fairly simple. First download the [ZinnaCocoaTouch](https://github.com/shinjukunian/iOS-Zinnia-Japanese-Handwriting-Input) library and put it somewhere in your working directory

![](https://raw.githubusercontent.com/tuanna-hsp/file-hosting/master/Repo/kanji-handwriting-swift/1.jpeg)


Add the library to your project from XCode

![](https://raw.githubusercontent.com/tuanna-hsp/file-hosting/master/Repo/kanji-handwriting-swift/2.jpeg)

![](https://raw.githubusercontent.com/tuanna-hsp/file-hosting/master/Repo/kanji-handwriting-swift/3.jpeg)


If you see the library files appear in XCode like this then it's great.

![](https://raw.githubusercontent.com/tuanna-hsp/file-hosting/master/Repo/kanji-handwriting-swift/4.jpeg)


Next we will configure your project to link with the library.
Open you **Project settings** → **Build phases**. At the **Target Dependencies**, add `ZinniaCocoaTouch`

![](https://raw.githubusercontent.com/tuanna-hsp/file-hosting/master/Repo/kanji-handwriting-swift/5.jpeg)


Next, at the **Link Binary With Libraries**, add `ZinniaCocoaTouch.framework`

![](https://raw.githubusercontent.com/tuanna-hsp/file-hosting/master/Repo/kanji-handwriting-swift/6.jpeg)


To make the provided model (you will see it in `ZinniaCocoaTouch/Supporting Files/handwriting.model`) bundled with the build, we need to add a Copy Files Phases

![](https://raw.githubusercontent.com/tuanna-hsp/file-hosting/master/Repo/kanji-handwriting-swift/7.jpeg)
![](https://raw.githubusercontent.com/tuanna-hsp/file-hosting/master/Repo/kanji-handwriting-swift/8.jpeg).


Next, create an Objective-C bridging header to import the library classes to your Swift files.

![](https://raw.githubusercontent.com/tuanna-hsp/file-hosting/master/Repo/kanji-handwriting-swift/9.jpeg)


If your project still doesn't compile, check the **Build Settings** for whether the header has been properly configured.

![](https://raw.githubusercontent.com/tuanna-hsp/file-hosting/master/Repo/kanji-handwriting-swift/10.jpeg)

That's it! Congratulation, you has successfully intergrate Zinnia into your project.

### How to use the library
See [DrawableView.swift](https://github.com/tuanna-hsp/kanji-handwriting-swift/blob/master/kanji-handwriting-swift/Views/DrawableView.swift) on how to handle the hand-drawing and [HandritingViewModel.swift](https://github.com/tuanna-hsp/kanji-handwriting-swift/blob/master/kanji-handwriting-swift/ViewModels/HandwritingViewModel.swift) on how to use the library.

Basically we create an instance of `Recognizer` and for each stroke that has been drawn, we feed that to `Recognizer.classify()` method, which accepts an `[NSValue]` as argument.
The method returns a `Result` that represent the classified values ordered by confidency. We can apply `result!.map { $0.value }` to get and array of `String`, each of element represents a kanji.

### ※Note
If you use a third-party library which is also define a `Result` class  (for example [Alamofire](https://github.com/Alamofire/Alamofire)), XCode may failed to resolve.
To this you can modify the `Result.h` and `Result.m` and change the interface name to something else, like `ZinniaResult` to avoid the conflict.

![](https://raw.githubusercontent.com/tuanna-hsp/file-hosting/master/Repo/kanji-handwriting-swift/11.jpeg)