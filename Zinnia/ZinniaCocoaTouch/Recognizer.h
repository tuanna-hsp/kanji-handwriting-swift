//
//  Zinnia.h
//  ZinniaSample
//
//  Created by Watanabe Toshinori on 10/12/27.
//  Copyright 2010 FLCL.jp. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TargetConditionals.h"
#if TARGET_OS_IPHONE
#define valueWithPoint valueWithCGPoint
#define pointValue CGPointValue
#import <UIKit/UIKit.h>
#endif

@class Result;
@interface Recognizer : NSObject

@property NSUInteger count;
@property (nonatomic) CGSize canvasSize;
@property (nonatomic) NSUInteger maxResults;

-(nonnull instancetype)initWithSize:(CGSize)canvasSize;
-(nonnull instancetype)initWithSize:(CGSize)canvasSize modelAtURL:(nonnull NSURL*)url;

-(nonnull NSArray <Result *> *)classify:(nonnull NSArray <NSValue*>*)points;
-(void)clear;

@end
