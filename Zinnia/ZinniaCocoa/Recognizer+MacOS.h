//
//  Recognizer+MacOS.h
//  ZinniaCocoa
//
//  Created by Morten Bertz on 2017/10/11.
//  Copyright © 2017 Morten Bertz. All rights reserved.
//

#import "Recognizer.h"
#import <AppKit/AppKit.h>

@interface Recognizer (MacOS)

-(nonnull instancetype)initWithCanvas:(nonnull NSView*)canvas modelAtURL:(nonnull NSURL*)url;
-(nonnull instancetype)initWithCanvas:(nonnull NSView*)canvas;

@end
