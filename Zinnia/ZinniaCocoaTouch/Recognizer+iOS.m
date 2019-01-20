//
//  Recognizer+iOS.m
//  ZinniaCocoaTouch
//
//  Created by Morten Bertz on 2017/10/11.
//  Copyright © 2017 Morten Bertz. All rights reserved.
//

#import "Recognizer+iOS.h"

@implementation Recognizer (iOS)

-(nonnull instancetype)initWithCanvas:(UIView *)canvas modelAtURL:(NSURL *)url{
    return [self initWithSize:canvas.frame.size modelAtURL:url];
}
-(nonnull instancetype)initWithCanvas:(nonnull UIView*)canvas{
    return [self initWithSize:canvas.frame.size];
}


@end
