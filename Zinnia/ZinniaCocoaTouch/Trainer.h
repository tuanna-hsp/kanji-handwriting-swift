//
//  Trainer.h
//  ZinniaCocoaTouch
//
//  Created by Morten Bertz on 5/15/15.
//  Copyright (c) 2015 Morten Bertz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface CharacterStroke :NSObject

@property (nonnull)NSString *character;
@property CGSize size;
@property (nonnull) NSArray <NSArray<NSValue*>*> *strokes;

@end



@interface Trainer : NSObject

-(void)trainWithSEXPModels:(nonnull NSArray <NSURL*>*)paths completion:(void (^ _Nonnull )(BOOL success,  NSURL * _Nullable  outputpath))completion;
-(void)convertTrainingData:(nonnull NSURL *)path compression:(double)compression completion:(void(^_Nonnull)(BOOL success, NSURL * _Nullable output))completion;
-(void)trainWithCharacters:(nonnull NSArray <CharacterStroke*>*)characters completion:(void (^_Nonnull)(BOOL, NSURL *_Nullable))completion;
-(nonnull instancetype)initWithURL:(nonnull NSURL*)url;


+(nonnull NSArray <CharacterStroke*>*)convertSEXP:(nonnull NSArray <NSURL*>*)paths;

@end
