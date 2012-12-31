//
//  FLStringBuilderLine.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/30/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLWhitespace.h"
#import "FLPrettyString.h"

@protocol FLStringBuilderLine <NSObject, NSCopying>
@property (readwrite, assign, nonatomic) NSInteger tabIndent;
@property (readwrite, assign, nonatomic) id parent;

- (void) appendSelfToPrettyString:(FLPrettyString*) prettyString;
- (NSUInteger) countLines;
- (BOOL) hasLines;                           
- (void) didMoveToParent:(id) parent;

@optional 
- (void) appendStringToLine:(NSString*) string;
                           
@end

@interface FLStringBuilderLine : NSObject<FLStringBuilderLine> {
@private 
    NSMutableString* _string;
    NSInteger _tabIndent;
    __unsafe_unretained id _parent;
}

- (id) initWithTabCount:(NSInteger) tabIndent;

+ (id) stringBuilderLine:(NSInteger) tabIndent;
+ (id) stringBuilderLine;

@property (readwrite, strong, nonatomic) NSString* string;
- (void) appendString:(NSString*) string;

@end
