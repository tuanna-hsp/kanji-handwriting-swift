//
//  Trainer.m
//  ZinniaCocoaTouch
//
//  Created by Morten Bertz on 5/15/15.
//  Copyright (c) 2015 Morten Bertz. All rights reserved.
//

#import "Trainer.h"
#import "zinnia.h"

#import "TargetConditionals.h"

#if TARGET_OS_IPHONE

#define valueWithPoint valueWithCGPoint
#define pointValue CGPointValue
@import UIKit;

#else


#endif





@implementation CharacterStroke



@end

@interface Trainer ()

@property NSURL *outURL;

@end

@implementation Trainer


-(instancetype)initWithURL:(NSURL *)url{
    self=[super init];
    if (self) {
        self.outURL=url;
    }
    return self;
}


-(void)trainWithSEXPModels:(NSArray *)paths completion:(void (^)(BOOL, NSURL *))completion{
    
    NSMutableArray *characters=[NSMutableArray array];

    
    for (NSURL *path in paths) {
        NSArray *pathArray =[self strokesFromSEXP:path];
        [characters addObjectsFromArray:pathArray];
    }
    if (!self.outURL) {
        NSString *outputName=[[[paths.firstObject lastPathComponent]stringByDeletingPathExtension]stringByAppendingString:@"_model"];
        NSString *output=[[[(NSURL*)paths.firstObject path]stringByDeletingLastPathComponent]stringByAppendingPathComponent:outputName];
        self.outURL=[NSURL fileURLWithPath:output];
    }
    [self trainWithCharacters:characters completion:completion];
}


-(void)trainWithCharacters:(NSArray <CharacterStroke*>*)characters completion:(void (^)(BOOL, NSURL *))completion{
    zinnia_character_t *character;
    zinnia_trainer_t *trainer;
    
    trainer=zinnia_trainer_new();
    character=zinnia_character_new();
    for (CharacterStroke *stroke in characters) {
        /*
         ":" (colon) is used by zinnia as a separator character in the temporary training text file, colon is added, conversion to training binary will fail
         
         */
        if (stroke.strokes.count>0 && stroke.size.height>0 && stroke.size.width>0 && ![stroke.character isEqualToString:@":"]) {
            NSString *kanji=stroke.character;
            zinnia_character_set_value(character, [kanji cStringUsingEncoding:NSUTF8StringEncoding]);
            zinnia_character_set_width(character, stroke.size.width);
            zinnia_character_set_height(character, stroke.size.height);
            
            for (NSUInteger i=0; i<stroke.strokes.count; i++) {
                NSArray *singleStrokeArray=stroke.strokes[i];
                for (NSValue *strokeValue in singleStrokeArray) {
                    CGPoint point=[strokeValue pointValue];
                    zinnia_character_add(character, i, point.x, point.y);
                }
                
            }
            
            zinnia_trainer_add(trainer, character);
            zinnia_character_clear(character);
            
        }
        else{
            NSLog(@"invalid character: %@",stroke.character);
        }
        
    }
    
    int returnvalue =zinnia_trainer_train(trainer, [self.outURL.path cStringUsingEncoding:NSUTF8StringEncoding]);
    
    
    zinnia_character_destroy(character);
    zinnia_trainer_destroy(trainer);
    if (returnvalue==1) {
        completion(YES,self.outURL);
    }
    else{
        
        completion(NO,nil);
    }

}


-(void)convertTrainingData:(NSURL *)path compression:(double)compression completion:(void(^)(BOOL success, NSURL *output))completion{
    
    NSString *filename=path.path;
    NSString *outpuName=[[filename stringByDeletingPathExtension]stringByAppendingPathExtension:@"binary"];
    int success=  zinnia_trainer_convert_model([filename cStringUsingEncoding:NSUTF8StringEncoding], [outpuName cStringUsingEncoding:NSUTF8StringEncoding], compression);
    
    if (success==1) {
        completion(YES,[NSURL fileURLWithPath:outpuName]);

    }
    else{
        
        completion(NO,nil);

    }
    
    
}


+(nonnull NSArray <CharacterStroke*>*)convertSEXP:(nonnull NSArray <NSURL*>*)paths{
    Trainer *t=[Trainer new];
    NSMutableArray *characters=[NSMutableArray array];
    for (NSURL *path in paths) {
        NSArray *pathArray =[t strokesFromSEXP:path];
        [characters addObjectsFromArray:pathArray];
    }
    return characters.copy;
}






-(NSArray*)strokesFromSEXP:(NSURL*)path{
    
   
    NSError *charactersError;
    NSString *characters=[NSString stringWithContentsOfFile:path.path encoding:NSUTF8StringEncoding error:&charactersError];
    NSScanner *reusableLineScanner=[[NSScanner alloc]initWithString:characters];
    NSMutableArray *array=[NSMutableArray array];
    while (!reusableLineScanner.isAtEnd) {
        NSString *line;
        NSMutableArray *strokes=[NSMutableArray array];
        if ([reusableLineScanner scanUpToCharactersFromSet:[NSCharacterSet newlineCharacterSet] intoString:&line]) {
            NSString *value;
            NSScanner *detail=[[NSScanner alloc]initWithString:line];
            [detail scanUpToString:@"value" intoString:NULL];
            [detail scanString:@"value" intoString:NULL];
            [detail scanUpToString:@")" intoString:&value];
            NSInteger height;
            NSInteger width;
            [detail scanUpToString:@"width" intoString:NULL];
            [detail scanString:@"width" intoString:NULL];
            [detail scanInteger:&width];
            [detail scanUpToString:@"height" intoString:NULL];
            [detail scanString:@"height" intoString:NULL];
            [detail scanInteger:&height];
            [detail scanUpToString:@"strokes" intoString:NULL];
            NSString *stroke;
            [detail scanUpToCharactersFromSet:[NSCharacterSet newlineCharacterSet] intoString:&stroke];
            NSScanner *strokeScanner=[[NSScanner alloc]initWithString:stroke];
            
            while (!strokeScanner.isAtEnd) {
                NSMutableArray *singleStrokeArray=[NSMutableArray array];
                NSString *singleStroke;
                [strokeScanner scanUpToString:@"((" intoString:NULL];
                if ( [strokeScanner scanUpToString:@"))" intoString:&singleStroke]) {
                    NSScanner *pointScanner=[[NSScanner alloc]initWithString:singleStroke];
                    NSCharacterSet *brackets=[NSCharacterSet characterSetWithCharactersInString:@"()"];
                    NSMutableCharacterSet *skip=[[NSCharacterSet whitespaceCharacterSet]mutableCopy];
                    [skip formUnionWithCharacterSet:brackets];
                    pointScanner.charactersToBeSkipped=skip;
                    while (!pointScanner.isAtEnd) {
                        double p1;
                        double p2;
                        [pointScanner scanDouble:&p1];
                        [pointScanner scanDouble:&p2];
                        CGPoint point=CGPointMake(p1, p2);
                        [singleStrokeArray addObject:[NSValue valueWithPoint:point]];
                    }
                    [strokes addObject:singleStrokeArray.copy];
                }
                
            }
            
            CharacterStroke *newCharacter=[CharacterStroke new];
            newCharacter.character=value;
            newCharacter.size=CGSizeMake(width, height);
            newCharacter.strokes=strokes;
            [array addObject:newCharacter];
            
        }
    }
    return array.copy;
}


@end
