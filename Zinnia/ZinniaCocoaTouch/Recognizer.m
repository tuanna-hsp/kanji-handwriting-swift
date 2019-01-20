//
//  Zinnia.m
//  ZinniaSample
//
//  Created by Watanabe Toshinori on 10/12/27.
//  Copyright 2010 FLCL.jp. All rights reserved.
//

#import "Recognizer.h"
#import "Result.h"
#import "zinnia.h"



@implementation Recognizer{
    
    zinnia_recognizer_t *recognizer;
    zinnia_character_t *character;
    
    
}


-(nonnull instancetype)initWithSize:(CGSize)canvasSize{
    if (self =[super init]) {
        NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource:@"handwriting" ofType:@"model"];
        recognizer = zinnia_recognizer_new();
        if (!zinnia_recognizer_open(recognizer, [path cStringUsingEncoding:NSASCIIStringEncoding])) {
            fprintf(stderr, "ERROR: %s\n", zinnia_recognizer_strerror(recognizer));
        }
        
        character  = zinnia_character_new();
        zinnia_character_clear(character);
        zinnia_character_set_width(character, canvasSize.width);
        zinnia_character_set_height(character,  canvasSize.height);
        
        _count = 0;
        self.maxResults=10;
    }
    return self;
}


-(instancetype)initWithSize:(CGSize)canvasSize modelAtURL:(NSURL *)url{
    if (self =[super init]) {
        
        recognizer = zinnia_recognizer_new();
        if (!zinnia_recognizer_open(recognizer, url.fileSystemRepresentation)) {
            fprintf(stderr, "ERROR: %s\n", zinnia_recognizer_strerror(recognizer));
        }
        
        character  = zinnia_character_new();
        zinnia_character_clear(character);
        zinnia_character_set_width(character, canvasSize.width);
        zinnia_character_set_height(character,canvasSize.height);
        
        _count = 0;
        self.maxResults=10;
        
    }
    return self;
}





-(void)setCanvasSize:(CGSize)canvasSize{
    _canvasSize=canvasSize;
    zinnia_character_set_width(character, canvasSize.width);
    zinnia_character_set_height(character, canvasSize.height);
}

- (NSArray *)classify:(NSArray *)points {

	for (NSValue *value in points) {
		CGPoint point = [value pointValue];
		zinnia_character_add(character, _count, point.x, point.y);
	}
	
	zinnia_result_t *result;
	result = zinnia_recognizer_classify(recognizer, character, self.maxResults);
	if (result == NULL) {
		fprintf(stderr, "%s\n", zinnia_recognizer_strerror(recognizer));
		return nil;
	}

	NSMutableArray *results = [NSMutableArray array];
	for (int i = 0; i < zinnia_result_size(result); ++i) {
		NSString *value = [NSString stringWithCString:zinnia_result_value(result, i) encoding:NSUTF8StringEncoding];
		NSNumber *score = [NSNumber numberWithFloat:zinnia_result_score(result, i)];
        Result *result = [Result new];
        result.value = value;
        result.score = score;
        [results addObject:result];
		
	}
	zinnia_result_destroy(result);

	// Increment line number.
	_count ++;
	
	return [NSArray arrayWithArray:results];
}

- (void)clear {
	
	// Reset line number.
	_count = 0;

	zinnia_character_clear(character);
}

- (void)dealloc {
	zinnia_character_destroy(character);
	zinnia_recognizer_destroy(recognizer);
}

@end
