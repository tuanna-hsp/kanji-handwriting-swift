//
//  Recognizer+MacOS.m
//  ZinniaCocoa
//
//  Created by Morten Bertz on 2017/10/11.
//  Copyright © 2017 Morten Bertz. All rights reserved.
//

#import "Recognizer+MacOS.h"

@implementation Recognizer (MacOS)

-(nonnull instancetype)initWithCanvas:(NSView *)canvas modelAtURL:(NSURL *)url{
    return [self initWithSize:canvas.frame.size modelAtURL:url];
}
-(nonnull instancetype)initWithCanvas:(nonnull NSView*)canvas{
    return [self initWithSize:canvas.frame.size];
}

@end
