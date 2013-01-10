//
//  FLParseableInput.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 1/9/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLStringFormatter.h"

typedef NSRange (^FLParseableInputBlock)(NSString* string);

typedef void (^FLParseableInputCommitBlock)(FLStringFormatter* output);

@interface FLParseableInput : NSObject {
@private
    NSMutableArray* _history;
    NSString* _string;
    NSRange _remainingRange;
    
    NSMutableArray* _commits;
}

@property (readonly, strong, nonatomic) NSArray* history;

@property (readonly, copy, nonatomic) NSString* string;
@property (readonly, strong, nonatomic) NSString* unparsed;

@property (readonly, assign, nonatomic) NSRange remainingRange;

- (id) initWithString:(NSString*) string;
+ (id) parseableInput:(NSString*) string;

@property (readonly, strong, nonatomic) NSString* last;
@property (readonly, assign, nonatomic) BOOL hasMore;
- (NSString*) next;
- (NSString*) nextWithBlock:(FLParseableInputBlock) parseNextBlock;

- (void) addCommitBlock:(FLParseableInputCommitBlock) commitBlock;

- (void) commitWithOutput:(FLStringFormatter*) output;

//- (NSString*) peek;
//- (NSString*) peekNextWithBlock:(FLParseableInputBlock) parseNextBlock;



@end