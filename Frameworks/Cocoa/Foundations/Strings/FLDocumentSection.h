//
//  FLDocumentSection.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLWhitespace.h"
#import "FLStringFormatter.h"
#import "FLPrettyString.h"

@interface FLDocumentSection : FLStringFormatter<FLBuildableString> {
@private
    NSMutableArray* _lines;
    BOOL _needsLine;
    __unsafe_unretained id _parent;
}
+ (id) stringBuilder;

@property (readonly, strong, nonatomic) NSArray* lines;
@property (readwrite, assign, nonatomic) id parent;

- (void) addStringBuilder:(FLDocumentSection*) stringBuilder;

// optional overrides
//- (NSMutableString*) willOpenLine;
//- (void) willCloseLine:(NSMutableString*) line;

- (void) willBuildWithStringFormatter:(id<FLStringFormatter>) stringFormatter;
- (void) didBuildWithStringFormatter:(id<FLStringFormatter>) stringFormatter;

- (void) didMoveToParent:(id) parent;

@end


