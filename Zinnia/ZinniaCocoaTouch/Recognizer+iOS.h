//
//  Recognizer+iOS.h
//  ZinniaCocoaTouch
//
//  Created by Morten Bertz on 2017/10/11.
//  Copyright © 2017 Morten Bertz. All rights reserved.
//

#import "Recognizer.h"

@interface Recognizer (iOS)

-(nonnull instancetype)initWithCanvas:(nonnull UIView*)canvas modelAtURL:(nonnull NSURL*)url;
-(nonnull instancetype)initWithCanvas:(nonnull UIView*)canvas;

@end
