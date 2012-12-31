//
//  FLStringBuilderLine.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/30/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLWhitespace.h"
#import "FLPrettyString.h"

@protocol FLStringBuilderLine <NSObject, NSCopying, FLBuildableString>
@optional 
@property (readwrite, assign, nonatomic) id parent;
- (void) didMoveToParent:(id) parent;
- (void) appendStringToLine:(NSString*) string;
@end

@interface FLStringBuilderLine : NSObject<FLStringBuilderLine> {
@private 
    NSMutableString* _string;
    __unsafe_unretained id _parent;
}

+ (id) stringBuilderLine;

@property (readwrite, strong, nonatomic) NSString* string;
- (void) appendString:(NSString*) string;

@end
