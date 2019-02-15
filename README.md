## Kanji handwriting recognition for iOS using Zinnia.

![](https://raw.githubusercontent.com/tuanna-hsp/file-hosting/master/Repo/kanji-handwriting-swift/screen-capture.gif)

### Overview
[Zinnia](http://taku910.github.io/zinnia/) is a great handwriting recognition library based on SVM. Our [Japanese dictionary app](https://itunes.apple.com/jp/app/suge-dict-tu-dien-nhat-viet/id1446211651) uses a customized version of Zinnia, called [ZinnaCocoaTouch](https://github.com/shinjukunian/iOS-Zinnia-Japanese-Handwriting-Input), for the Kanji input engine.

This sample demonstrates how to use ZinnaCocoaTouch (which already provided the model and interface implementation in *Objective-C*) in an iOS project.
It is written in Swift 4 with XCode 10.1.

### Integrate Zinnia to your existing project
The process is a bit long but fairly simple. 
Look [here](https://github.com/tuanna-hsp/kanji-handwriting-swift/blob/master/INTERGRATE_TO_EXISTING_PROJECT.md) for detailed instructions.

### How to use the library
See [DrawableView.swift](https://github.com/tuanna-hsp/kanji-handwriting-swift/blob/master/kanji-handwriting-swift/Views/DrawableView.swift) for a simple implementation of the drawing canvas and [HandritingViewModel.swift](https://github.com/tuanna-hsp/kanji-handwriting-swift/blob/master/kanji-handwriting-swift/ViewModels/HandwritingViewModel.swift) on how to use the library.

Basically, we create an instance of `Recognizer` and for each newly drawn stroke, feed that to `Recognizer.classify()` method which accepts an `[NSValue]` as the argument.
The method returns a `Result` that represent the classified values ordered by confidence. Then we can apply `result!.map { $0.value }` to get an array of `String`, each of which represents a kanji.

### Note
When you use a third-party library which is also happen to define a `Result` class  ([Alamofire](https://github.com/Alamofire/Alamofire) for example), XCode may fail to resolve.
If that happens, look into [Result.h](https://github.com/tuanna-hsp/kanji-handwriting-swift/blob/master/Zinnia/ZinniaCocoaTouch/Result.h), [Result.m](https://github.com/tuanna-hsp/kanji-handwriting-swift/blob/master/Zinnia/ZinniaCocoaTouch/Result.m) and change the interface name to something else, like `ZinniaResult` to avoid the conflict.
