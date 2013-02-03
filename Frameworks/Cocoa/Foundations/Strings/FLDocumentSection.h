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

@interface FLDocumentSection : FLStringFormatter<FLStringFormatterDelegate, FLBuildableString> {
@private
    NSMutableArray* _lines;
    BOOL _needsLine;
    __unsafe_unretained id _parent;
    
    NSMutableString* _openLine;
}
+ (id) stringBuilder;

@property (readonly, strong, nonatomic) NSArray* lines;
@property (readwrite, assign, nonatomic) id parent;

- (void) addStringBuilder:(FLDocumentSection*) stringBuilder;

// optional overrides
- (NSMutableString*) willOpenLine;
- (void) willCloseLine:(NSMutableString*) line;

- (void) willBuildWithPrettyString:(FLPrettyString*) prettyString;
- (void) didBuildWithPrettyString:(FLPrettyString*) prettyString;

- (void) didMoveToParent:(id) parent;

@end


